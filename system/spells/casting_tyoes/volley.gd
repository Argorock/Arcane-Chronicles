extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.1
	speed_multiplier = 1.0
	range_multiplier = 1.1
	mana_cost_multiplier = 1.1
	
	origin = Origin.SKY
	shape = Shape.AREA
	motion = Motion.FALLING
	persistence = Persistence.BURST
	
	projectile_count = 8
	spread_angle = 15
	arc_height = 3
