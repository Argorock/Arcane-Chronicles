extends CastingTypeData

func _init():
	type_name = "Arc"
	description = "Cast this spell in an arc"
	
	pattern = Pattern.SINGLE

	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.0
	speed_multiplier = 1.3
	range_multiplier = 1.1
	mana_cost_multiplier = 1.0

	origin = Origin.CASTER
	shape = Shape.ARC
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT

	projectile_count = 1
	spread_degrees = 0.0
	arc_height = 10.0
	gravity_enabled = true

