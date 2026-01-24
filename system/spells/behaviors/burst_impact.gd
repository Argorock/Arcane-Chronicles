extends BehaviorData

@export var burst_radius: float = 2.0
@export var burst_damage: float = 10.0

func _init():
	behavior_name = "Burst Impact"
	description = "Creates a small burst of damage on hit"
	
func on_hit(spell, target):
	var enemies = spell.get_entities_in_radius(spell.global_position, burst_radius)
	for e in enemies:
		e.apply_damage(burst_damage)
