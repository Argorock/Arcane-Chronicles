extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.0
	speed_multiplier = .95
	range_multiplier = 1.1
	mana_cost_multiplier = 1.0
	
	origin = Origin.CASTER
	shape = Shape.ARC
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT
	
	projectile_count = 1
	spread_angle = 0.0
	arc_height = 1.0
