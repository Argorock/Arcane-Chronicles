extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = .9
	cooldown_multiplier = 1.2
	speed_multiplier = 1.0
	range_multiplier = 1.2
	mana_cost_multiplier = 1.1
	
	origin = Origin.TARGET
	shape = Shape.NONE
	motion = Motion.STATIC
	persistence = Persistence.SEQUENTIAL
	
	projectile_count = 0
	spread_angle = 0.0
	arc_height = 0.0
