extends CastingTypeData

var cone_length: float = 1.0   # normalized length
var cone_width: float = 1.0    # normalized width

func _init():
	type_name = "Cone"
	description = "A short‑range, wide‑angle burst."

	pattern = Pattern.CONE
	uses_cone = true

	cone_scene = preload("res://system/spells/cone.tscn")

	# Cone-specific geometry defaults
	cone_length = .1
	cone_width = 50.0

	cast_time_multiplier = 1.0
	cooldown_multiplier = 1.0
	speed_multiplier = 1.0
	range_multiplier = 0.9
	mana_cost_multiplier = 1.05

	origin = Origin.CASTER
	shape = Shape.CONE
	motion = Motion.STATIC
	persistence = Persistence.CONTINUOUS

	projectile_count = 0
	spread_degrees = 60
	arc_height = 0.0
