extends CastingTypeData

func _init():
	type_name = "Bolt"
	description = "A fast, forward-traveling projectile."
	
	pattern = Pattern.SINGLE

	cast_time_multiplier = 0.95
	cooldown_multiplier = 1.0
	speed_multiplier = 1.5
	range_multiplier = 1.0
	mana_cost_multiplier = 1.0

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT

	projectile_count = 1
	spread_degrees = 0.0
	arc_height = 0.0
	projectile_scale = 0.8

