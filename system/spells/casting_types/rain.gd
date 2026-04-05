extends CastingTypeData

func _init():
	type_name = "Rain"
	description = "Chaotic projectiles falling over a wide area."
	
	pattern = Pattern.RAIN

	cast_time_multiplier = 1.15
	cooldown_multiplier = 0.01
	speed_multiplier = 1.3
	range_multiplier = 1.2
	mana_cost_multiplier = 1.15

	#origin = Origin.SKY
	shape = Shape.AREA
	motion = Motion.FALLING
	persistence = Persistence.CONTINUOUS

	projectile_count = 1
	spread_degrees = 20
	arc_height = 5.0
	projectile_scale = 0.2
 
	gravity_enabled = true
