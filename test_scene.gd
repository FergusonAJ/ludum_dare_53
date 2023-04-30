extends Node2D

var graph_manager;

# Called when the node enters the scene tree for the first time.
func _ready():
	graph_manager = get_node("GraphManager")
	
	graph_manager.add_component(GraphManager.NodeType.GENERATOR, 100, 100).gen_load.create_charge(EnergyCharge.ChargeType.RED, 1)
	graph_manager.add_component(GraphManager.NodeType.GENERIC, 200, 200)
	graph_manager.add_component(GraphManager.NodeType.JUNCTION, 300, 300).input_edge_list = [1, 3]
	graph_manager.add_component(GraphManager.NodeType.GENERIC, 400, 200)
	graph_manager.add_component(GraphManager.NodeType.GENERATOR, 500, 100).gen_load.create_charge(EnergyCharge.ChargeType.GREEN, 2)
	graph_manager.add_component(GraphManager.NodeType.GENERIC, 300, 400)
	
	graph_manager.add_connection(0, 1)
	graph_manager.add_connection(1, 2)
	graph_manager.add_connection(2, 3)
	graph_manager.add_connection(3, 4)
	graph_manager.add_connection(2, 5)
	
	graph_manager.process_graph()
	
	print('Prior to for loop')
	for i in range(6):
		print('Node: ', i, ' Load:', graph_manager.node_map[i].process_load())
	
	# New start index = 6
	#graph_manager.add_component(GraphManager.NodeType.GENERATOR, 100, 500)
	#junction = graph_manager.add_component(GraphManager.NodeType.JUNCTION, 200, 500)
	#junction.input_edge_list = [6, 8]
	#graph_manager.add_component(GraphManager.NodeType.GENERIC, 300, 500)
	#graph_manager.add_component(GraphManager.NodeType.GENERIC, 400, 500)
	#graph_manager.add_component(GraphManager.NodeType.GENERIC, 500, 500)
	#graph_manager.add_component(GraphManager.NodeType.GENERATOR, 600, 500)
	#graph_manager.add_component(GraphManager.NodeType.GENERIC, 200, 600)
	
	#graph_manager.add_connection(6, 7)
	#graph_manager.add_connection(7, 8)
	#graph_manager.add_connection(8, 9)
	#graph_manager.add_connection(9, 10)
	#graph_manager.add_connection(10, 11)
	#graph_manager.add_connection(7, 12)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
