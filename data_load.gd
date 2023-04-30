extends Node

class_name DataLoad

var energy_charges = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_charge(type, phase):
	var new_charge = EnergyCharge.new()
	new_charge.type = type
	new_charge.phase = phase
	if new_charge.type in energy_charges.keys():
		energy_charges[type].AddCharge(new_charge)
	else:
		energy_charges[type] = new_charge.make_copy()
	
func add_charge(new_charge):
	if new_charge.type not in energy_charges.keys():
		energy_charges[new_charge.type] = new_charge.make_copy()
	else:
		energy_charges[new_charge.type].AddCharge(new_charge)
		

func add(other_load):
	# First, add all the energies we know about
	for energy_type in energy_charges.keys():
		if energy_type in other_load.energy_charges.keys():
			energy_charges[energy_type].add(other_load.energy_charges[energy_type])
	# Next, look for any energies we haven't been keeping track of yet
	for energy_type in other_load.energy_charges.keys():
		if not energy_type in energy_charges.keys():
			energy_charges[energy_type] = other_load.energy_charges[energy_type].make_copy()

func clear():
	energy_charges.clear()
	
func make_copy():
	var new_copy = DataLoad.new()
	new_copy.energy_charges = {}
	for key in energy_charges:
		var type = energy_charges[key].type
		new_copy.energy_charges[type] = energy_charges[key].make_copy()
	return new_copy

func _to_string():
	var s = '['
	if EnergyCharge.ChargeType.RED in energy_charges:
		s += var_to_str(energy_charges[EnergyCharge.ChargeType.RED].phase)
	else:
		s += '0'
	s +=','
	if EnergyCharge.ChargeType.GREEN in energy_charges:
		s += var_to_str(energy_charges[EnergyCharge.ChargeType.GREEN].phase)
	else:
		s += '0'
	s +=','
	if EnergyCharge.ChargeType.BLUE in energy_charges:
		s += var_to_str(energy_charges[EnergyCharge.ChargeType.BLUE].phase)
	else:
		s += '0'
	s += ']'
	return s
	
	
