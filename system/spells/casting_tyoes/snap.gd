extends CastingTypeData

func _init():
	type_name = "Snap"
	description = "short range fast cast enegery beam"
	
	cooldown_multiplier = 1.05
	speed_multiplier = 1
	range_multiplier = .3
	mana_cost_multiplier = 1
	
	is_instant = true
