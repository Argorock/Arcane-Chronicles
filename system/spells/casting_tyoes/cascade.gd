extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.25
	speed_multiplier = 1.0
	range_multiplier = 1.15
	mana_cost_multiplier = 1.2
	
	origin = Origin.SKY
	shape = Shape.LINE
	motion = Motion.SWEEPING
	persistence = Persistence.SEQUENTIAL
	
	projectile_count = 12
	spread_angle = 5.0
	arc_height = 3.0
