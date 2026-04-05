extends CastingTypeData

func _init():
	type_name = "Burst Fire"
	description = "Fires several projectiles in rapid succession."
	
	pattern = Pattern.BURST

	cast_time_multiplier = 1.1
	cooldown_multiplier = 0.6
	speed_multiplier = 1.0
	range_multiplier = 1.0
	mana_cost_multiplier = 1.1

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.SEQUENTIAL
	persistence = Persistence.CONTINUOUS

	projectile_count = 3
	spread_degrees = 5
	arc_height = 0.0
	projectile_scale = 0.7
