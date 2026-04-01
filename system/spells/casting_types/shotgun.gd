extends CastingTypeData

func _init():
	type_name = "Shotgun"
	description = "A close‑range blast of multiple projectiles."
	
	pattern = Pattern.SHOTGUN

	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.1
	speed_multiplier = 3.0
	range_multiplier = 0.6
	mana_cost_multiplier = 1.1

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT

	projectile_count = 8
	spread_degrees = 5
	arc_height = 0.0
	projectile_scale = 0.3
	gravity_enabled = true
