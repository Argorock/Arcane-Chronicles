extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.1
	speed_multiplier = 1.0
	range_multiplier = 1.1
	mana_cost_multiplier = 1.15
	
	origin = Origin.CASTER
	shape = Shape.LINE
	motion = Motion.STATIC
	persistence = Persistence.CONTINUOUS
	
	projectile_count = 0
	spread_angle = 0.0
	arc_height = 0.0
	
