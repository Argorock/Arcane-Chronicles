extends CastingTypeData

func _init():
	type_name = "Self"
	description = "Cast this spell upon yourself"
	
	cast_time_multiplier = .9
	cooldown_multiplier = .9
	speed_multiplier = 0.0
	range_multiplier = 0.0
	mana_cost_multiplier = .9
	
	origin = Origin.CASTER
	shape = Shape.NONE
	motion = Motion.STATIC
	persistence = Persistence.INSTANT
	
	projectile_count = 0
	spread_angle = 0.0
	arc_height = 0.0
	
func apply_special_rules(spell):
	spell.target = spell.caster
	
