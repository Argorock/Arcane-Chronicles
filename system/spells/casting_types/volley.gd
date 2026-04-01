extends CastingTypeData

func _init():
	type_name = "Volley"
	description = "A burst of falling projectiles over an area."
	
	pattern = Pattern.VOLLEY

	uses_projectile = true
	uses_instant_hit = false
	uses_beam = false

	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.1
	speed_multiplier = 2.0
	range_multiplier = 1.1
	mana_cost_multiplier = 1.1


	persistence = Persistence.BURST

	projectile_count = 8
	spread_degrees = 30
	arc_height = 3
	gravity_enabled = true
