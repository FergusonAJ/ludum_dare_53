extends Node2D
class_name GraphManager

var adjacency_list = {}
var directed_adjacency_list = {}
var reversed_adjacency_list = {}
var next_id = 0
var node_map = {}
var generator_list = []

enum NodeType { GENERIC, GENERATOR, JUNCTION }

# Adds a component to the graph, with 
func add_component(node_type, pos_x, pos_y):
	var component = null
	if node_type == NodeType.GENERIC:
		component = GraphComponent.new(next_id, Vector2(pos_x, pos_y))
	if node_type == NodeType.JUNCTION:
		component = GraphComponent_Junction.new(next_id, Vector2(pos_x, pos_y))
	elif node_type == NodeType.GENERATOR:
		component = GraphComponent_Generator.new(next_id, Vector2(pos_x, pos_y))
		generator_list.append(component.id)
	add_child(component)
	adjacency_list[component.id] = {}
	node_map[component.id] = component
	print('Added node: ', next_id)
	next_id += 1
	return component

# Add a connection (edge) between two nodes
func add_connection(idx_a, idx_b):
	adjacency_list[idx_a][idx_b] = true
	adjacency_list[idx_b][idx_a] = true
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_draw()

# Draw edges and possibly arrows to indicate direction	
func draw_connections():
	# Draw generic lines
	for index_a in adjacency_list.keys():
		var node_a = node_map[index_a]
		for index_b in adjacency_list[index_a].keys():
			if index_a < index_b: # Don't double draw!
				continue
			var node_b = node_map[index_b]
			draw_line(node_a.pos, node_b.pos, Color.WHITE)
	# Don't draw directions if we don't know them!
	if directed_adjacency_list.size() == 0:
		return
	# Draw directed arrows
	for index_a in directed_adjacency_list.keys():
		var node_a = node_map[index_a]
		for index_b in directed_adjacency_list[index_a].keys():
			var node_b = node_map[index_b]
			var arrow_points_vec = PackedVector2Array()
			var midpoint = (node_a.pos + node_b.pos) / 2
			var dir = node_a.pos.direction_to(node_b.pos)
			var ortho = dir.orthogonal()
			var arrow_size = 7
			arrow_points_vec.push_back(midpoint + dir * arrow_size)
			arrow_points_vec.push_back(midpoint - (dir * arrow_size) + ortho * arrow_size)
			arrow_points_vec.push_back(midpoint - (dir * arrow_size) - ortho * arrow_size)
			draw_polygon(arrow_points_vec, PackedColorArray([Color.GRAY]))
		

# Render the connections of the graph
func _draw():
	draw_connections()

# Perform bookkeeping to store a directed edge between two components
func add_directed_edge(index_a, index_b):
	if index_a not in directed_adjacency_list:
		directed_adjacency_list[index_a] = {}
	directed_adjacency_list[index_a][index_b] = true
	if index_b not in reversed_adjacency_list:
		reversed_adjacency_list[index_b] = {}
	reversed_adjacency_list[index_b][index_a] = true
	
# Pass information through the graph
func process_graph():
	directed_adjacency_list = {}
	reversed_adjacency_list = {}
	var visited_list = []
	var discovered_list = []
	var frontier = []
	for i in adjacency_list.keys():
		node_map[i].clear_load()
		visited_list.append(false)
		discovered_list.append(false)
	# First, add all the generators to the frontier
	for gen_index in generator_list:
		visited_list[gen_index] = true
		frontier.append(gen_index)
		discovered_list[gen_index] = true
	
	while frontier.size() > 0:
		var node_idx = frontier.pop_front()
		var node = node_map[node_idx]
		#if visited_list[node_idx]:
		#	print('Cycle detected at node: ', node_idx)
		#print('Processing node: ', node_idx, ' ', node.type)
		visited_list[node_idx] = true
		directed_adjacency_list[node_idx] = {}
		if node.type == NodeType.GENERATOR or node.type == NodeType.GENERIC:
			var new_load = node.process_load()
			for neighbor_idx in adjacency_list[node_idx]:
				#print('  ', node_idx, ' ', neighbor_idx, ' ', visited_list[neighbor_idx])
				if not visited_list[neighbor_idx]:
					var neighbor = node_map[neighbor_idx]
					neighbor.receive_load(new_load)
					frontier.append(neighbor_idx)
					discovered_list[neighbor_idx] = true
					add_directed_edge(node_idx, neighbor_idx)
					#print('Directed edge: ', node_idx, ' -> ', neighbor_idx)
		elif node.type == NodeType.JUNCTION:
			if reversed_adjacency_list[node_idx].size() >= node.input_edge_list.size():
				var new_load = node.process_load()
				for neighbor_idx in adjacency_list[node_idx]:
					#print('  ', node_idx, ' ', neighbor_idx, ' ', visited_list[neighbor_idx])
					if not visited_list[neighbor_idx]:
						var neighbor = node_map[neighbor_idx]
						neighbor.receive_load(new_load)
						frontier.append(neighbor_idx)
						discovered_list[neighbor_idx] = true
						add_directed_edge(node_idx, neighbor_idx)
					#	print('Directed edge: ', node_idx, ' -> ', neighbor_idx)
			else:
				visited_list[node_idx] = false
				frontier.insert(1, node_idx)
