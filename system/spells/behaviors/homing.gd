extends BehaviorData

@export var turn_speed: float = 5.0

func _init():
	behavior_name = "Homing"
	description = "spell moves towards targets"
	
func on_tick(spell, delta):
	if spell.target == null:
		return
	var to_target = (spell.target.global_position - spell.global_position).normalized()
	spell.velocity = spell.velocity.lerp(to_target * spell.speed, turn_speed * delta)
