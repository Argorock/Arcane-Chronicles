extends CastingTypeData



func _init():
	type_name = "Multi‑Shot"
	description = "Fires multiple projectiles in a forward spread."
	 
	pattern = Pattern.MULTI

	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.1
	speed_multiplier = 0.95
	range_multiplier = 0.95
	mana_cost_multiplier = 1.1

	origin = Origin.CASTER
	shape = Shape.PROJECTILE
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.INSTANT

	projectile_count = 3
	spread_degrees = 15
	arc_height = 0.0
