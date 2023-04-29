extends Node2D
class_name GraphComponent
 
var id = -1
var pos = Vector2(0,0)
var type = GraphManager.NodeType.GENERIC

func _init(_id = -1, _pos = Vector2(0,0)):
	id = _id
	pos = _pos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	print('Drawing component at (', pos.x, ', ', pos.y, ')')
	draw_circle(Vector2(pos.x, pos.y), 10, Color.RED)

func get_output():
	pass
