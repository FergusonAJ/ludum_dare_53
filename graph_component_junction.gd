class_name GraphComponent_Junction extends GraphComponent

var input_edge_list = []

enum JunctionType {COMBINER, SPLITTER}
var junction_type = JunctionType.SPLITTER

# Called when the node enters the scene tree for the first time.
func _ready():
	type = GraphManager.NodeType.JUNCTION
	color = Color.GREEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_load():
	return current_load
	
func receive_load(new_load):
	current_load.add(new_load)

