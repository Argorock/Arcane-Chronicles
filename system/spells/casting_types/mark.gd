extends CastingTypeData

func _init():
	type_name = "Mark"
	description = "Applies a targeted mark for follow‑up effects."
	
	pattern = Pattern.MARK
	uses_projectile = false
	uses_instant_hit = true


	cast_time_multiplier = 0.9
	cooldown_multiplier = 1.2
	speed_multiplier = 1.0
	range_multiplier = 1.2
	mana_cost_multiplier = 1.1

	origin = Origin.TARGET
	shape = Shape.NONE
	motion = Motion.STATIC
	persistence = Persistence.SEQUENTIAL

	projectile_count = 0
	spread_degrees = 0.0
	arc_height = 0.0
