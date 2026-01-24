extends BehaviorData

@export var converge_strength: float = 2.0


func _init():
	behavior_name = "Homing"
	description = "spell moves towards targets"
	
func on_tick(spell, delta):
	var to_end = (spell.end_point - spell.global_position).normalized()
	spell.velocity = spell.velocity.lerp(to_end * spell. speed, converge_strength * delta)
	
	
	
