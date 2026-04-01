extends CastingTypeData

func _init():
	type_name = "Single Shot"
	description = "A single, precise forward projectile."

	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.0
	speed_multiplier = 1.0
	range_multiplier = 1.0
	mana_cost_multiplier = 1.0

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT

	projectile_count = 1
	spread_degrees = 0.0
	arc_height = 0.0
