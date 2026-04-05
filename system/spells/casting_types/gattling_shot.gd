extends CastingTypeData

func _init():
	type_name = "Gatling Shot"
	description = "Rapid‑fire continuous projectiles."
	
	pattern = Pattern.GATLING
	uses_projectile = true
	uses_instant_hit = false
	uses_beam = false

	cast_time_multiplier = .2
	cooldown_multiplier = 0.1
	speed_multiplier = 1.15
	range_multiplier = 0.9
	mana_cost_multiplier = 1.2

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.CONTINUOUS

	projectile_count = 1
	spread_degrees = 0.0
	arc_height = 0.0
	projectile_scale = 0.3
