extends Line2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sin_vals = []
var sin_slices = 100
var wave_scale = 100
var wave_y = 100
var cycles = 5
var offset_x = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(sin_slices):
		sin_vals.append(sin(2.0 * PI * i / sin_slices))

func _draw():
	#draw_line(Vector2(0,0), Vector2(50, 50), Color(255, 0, 0), 1)
	#draw_line(Vector2(50,50), Vector2(150, 50), Color(0, 255, 0), 1)
	for index in range(sin_slices - 1):	
		var x_1 = offset_x + wave_scale * index / sin_slices
		var x_2 = offset_x + wave_scale * (index + 1) / sin_slices
		var y_1 = wave_scale * sin_vals[index] + wave_y
		var y_2 = wave_scale * sin_vals[index+1] + wave_y
	#print(float(i) * 100 / sin_slices, ' ',  sin_vals[i] * 100)
		for cycle_idx in range(cycles):
			draw_line(Vector2(x_1 + wave_scale * cycle_idx, y_1), Vector2(x_2 + wave_scale * cycle_idx, y_2), Color(255,255,255))
  # TODO: Fix last step (hooks to first step of next wave)
  #for cycle_idx in range(cycles):
	#draw_line(Vector2(), Vector2(), Color(255,255,255))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset_x -= 100 * delta
	queue_redraw()
