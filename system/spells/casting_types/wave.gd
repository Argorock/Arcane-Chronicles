extends CastingTypeData

var wave_width := 1.5
var wave_length := 4.0

	
func _init():
	type_name = "Wave"
	description = "A forward‑moving wall of energy."
	
	pattern = Pattern.WAVE

	cast_time_multiplier = 1.1
	cooldown_multiplier = 1.0
	speed_multiplier = 0.4
	range_multiplier = 1.1
	mana_cost_multiplier = 1.0

	origin = Origin.CASTER
	shape = Shape.WALL
	motion = Motion.TRAVEL_FORWARD
	persistence = Persistence.BURST

	projectile_count = 0
	spread_degrees = 0.0
	arc_height = 0

