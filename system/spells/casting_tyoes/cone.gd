extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.0
	speed_multiplier = 1.0
	range_multiplier = .9
	mana_cost_multiplier = 1.05
	
	origin = Origin.CASTER
	shape = Shape.CONE
	motion = Motion.STATIC
	persistence = Persistence.BURST
	
	projectile_count = 0
	spread_angle = 60
	arc_height = 0.0
