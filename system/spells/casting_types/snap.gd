extends CastingTypeData

func _init():
	type_name = "Snap"
	description = "A fast, instant short‑range strike."
	
	pattern = Pattern.SNAP
	uses_instant_hit = true
	range_multiplier = 0.2


	cooldown_multiplier = 1.05
	speed_multiplier = 1.0
	mana_cost_multiplier = 1.0

	uses_instant_hit = true
