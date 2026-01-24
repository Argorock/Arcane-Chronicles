extends CastingTypeData

func _init():
	type_name = "Self"
	description = "spell rains down in an area, in a chaotic pattern"
	
	cast_time_multiplier = 1.15
	cooldown_multiplier = 1.2
	speed_multiplier = 1.0
	range_multiplier = 1.2
	mana_cost_multiplier = 1.15
	
	origin = Origin.SKY
	shape = Shape.AREA
	motion = Motion.FALLING
	persistence = Persistence.SEQUENTIAL
	
	projectile_count = 20
	spread_angle = 45
	arc_height = 5.0
