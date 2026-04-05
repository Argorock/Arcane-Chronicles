extends CastingTypeData

func _init():
	type_name = "Cascade"
	description = "A sweeping line of descending projectiles."
	
	pattern = Pattern.CASCADE

	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.15
	speed_multiplier = 1.0
	range_multiplier = 1.15
	mana_cost_multiplier = 1.2

	origin = Origin.SKY
	shape = Shape.LINE
	motion = Motion.SWEEPING
	persistence = Persistence.SEQUENTIAL

	projectile_count = 12
	spread_degrees = 5.0
	arc_height = 3.0
	projectile_scale = 0.5
