class_name GraphComponent_Generator extends GraphComponent

var gen_load = DataLoad.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	type = GraphManager.NodeType.GENERATOR
	color = Color.YELLOW

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_load():
	#print(gen_load)
	#print(gen_load.energy_charges)
	return gen_load.make_copy()
	
func receive_load(new_load):
	pass
