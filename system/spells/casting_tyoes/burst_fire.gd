extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.15
	speed_multiplier = 1.0
	range_multiplier = 1.0
	mana_cost_multiplier = 1.1
	
	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.SEQUENTIAL
	persistence = Persistence.SEQUENTIAL
	
	projectile_count = 3
	spread_angle = 5
	arc_height = 0.0
	
