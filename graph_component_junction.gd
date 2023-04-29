class_name GraphComponent_Junction extends GraphComponent

var input_edge_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	type = GraphManager.NodeType.JUNCTION

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_output():
	return 1
	
func _draw():
	draw_circle(pos, 10, Color.GREEN)

