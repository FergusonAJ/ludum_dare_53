extends Node

class_name EnergyCharge

enum ChargeType {RED, GREEN, BLUE}

var type = ChargeType.RED;
var phase = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add(other_charge):
	if type != other_charge.type:
		print('Error! Tried to add two different energy colors!')
		return null
	phase += other_charge.phase

func make_copy():
	var charge = EnergyCharge.new()
	charge.type = type
	charge.phase = phase
	return charge

func _to_string():
	var s = 'Energy charge ['
	match(type):
		ChargeType.RED:
			s += 'RED'
		ChargeType.GREEN:
			s += 'GREEN'
		ChargeType.BLUE:
			s += 'BLUE'
	s += ' -> ' + var_to_str(phase) + ']'
	return s
	
