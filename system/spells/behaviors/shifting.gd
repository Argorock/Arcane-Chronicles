extends BehaviorData
class_name ShiftingBehavior

@export var shift_interval: float = 0.3
@export var shift_angle: float = 45.0

var time_accum: float = 0.0

func _init():
	behavior_name = "Shifting"
	description = "Spell randomly changes direction."

func on_tick(projectile: Node2D, delta: float) -> void:
	time_accum += delta
	if time_accum >= shift_interval:
		time_accum = 0.0
		var random_angle: float = deg_to_rad(randf_range(-shift_angle, shift_angle))
		projectile.velocity = projectile.velocity.rotated(random_angle)
