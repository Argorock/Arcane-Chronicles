extends BehaviorData

@export var shift_interval: float = 0.3
@export var shift_angle: float = 45.0

var time_accum = 0.0


func _init():
	behavior_name = "Shifting"
	description = "spell randomly changes direction"
	
func on_tick(spell, delta):
	time_accum += delta
	if time_accum >= shift_interval:
		time_accum = 0.0
		var randon_angle = deg_to_rad(randf_range(-shift_angle, shift_angle))
		spell.velocity = spell.velocity.rotated(randon_angle)
