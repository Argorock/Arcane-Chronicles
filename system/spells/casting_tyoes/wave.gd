extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.0
	speed_multiplier = .9
	range_multiplier = 1.1
	mana_cost_multiplier = 1.0
	
	origin = Origin.CASTER
	shape = Shape.WALL
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.BURST
	
	projectile_count = 0
	spread_angle = 0.0
	arc_height = 2 # wall height
