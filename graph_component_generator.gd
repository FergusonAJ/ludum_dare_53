class_name GraphComponent_Generator extends GraphComponent

var gen_load = DataLoad.new()
var rect = Rect2()

# Called when the node enters the scene tree for the first time.
func _ready():
	type = GraphManager.NodeType.GENERATOR
	color = Color.YELLOW
	var side_length = 20
	rect.position = pos - Vector2(side_length / 2, side_length / 2)
	rect.size = Vector2(side_length, side_length)

func add_load(type, phase):
	gen_load.create_charge(type, phase)
	color = gen_load.get_color()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func process_load():
	#print(gen_load)
	#print(gen_load.energy_charges)
	return gen_load.make_copy()
	
func receive_load(new_load):
	pass

func _draw():
	draw_rect(rect, color)
