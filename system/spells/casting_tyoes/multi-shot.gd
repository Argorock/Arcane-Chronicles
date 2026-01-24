extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.1
	speed_multiplier = .95
	range_multiplier = .95
	mana_cost_multiplier = 1.1
	
	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT
	
	projectile_count = 3
	spread_angle = 15
	arc_height = 0.0
	
