class_name GraphComponent_Junction extends GraphComponent

var input_edge_list = []

enum JunctionType {COMBINER, SPLITTER}
var junction_type = JunctionType.SPLITTER
var points = PackedVector2Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	type = GraphManager.NodeType.JUNCTION
	color = Color.GREEN
	var radius = 15
	points.push_back(pos + Vector2.UP * radius)
	points.push_back(pos + Vector2.UP * radius * sin(210 * PI / 180) + Vector2.RIGHT * radius * cos(210 * PI / 180))
	points.push_back(pos + Vector2.UP * radius * sin(-30 * PI / 180) + Vector2.RIGHT * radius * cos(-30 * PI / 180))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_load():
	return current_load
	
func receive_load(new_load):
	current_load.add(new_load)
	color = current_load.get_color()

func _draw():
	draw_colored_polygon(points, color)
