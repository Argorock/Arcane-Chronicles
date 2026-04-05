extends CastingTypeData

func _init():
	type_name = "Pulse"
	description = "A radial burst emitted from the caster."

	pattern = Pattern.PULSE

	uses_projectile = true
	uses_instant_hit = false
	uses_beam = false

	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.1
	speed_multiplier = 2.0
	range_multiplier = 0.95
	mana_cost_multiplier = 1.0

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.BURST

	projectile_count = 0
	spread_degrees = 0.0
	arc_height = 0.0
	projectile_scale = 1.0

