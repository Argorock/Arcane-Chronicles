extends BehaviorData

@export var explosion_radius: float = 3.0
@export var explosion_damage: float = 20.0
@export var explosion_interval: float = .5

var time_accum = 0.0

func _init():
	behavior_name = "Exploding"
	description = "Spell Explodes as it travels"
	
func on_tick(spell, delta):
	time_accum += delta
	if time_accum >= explosion_interval:
		time_accum = 0.0
		_explode(spell)
	
func _explode(spell):
	var enemies = spell.get_entities_in_radius(spell.global_position, explosion_radius)
	for e in enemies:
		e.apply_damage(explosion_damage)
	spell.queue_free()
