extends BehaviorData
class_name HomingBehavior

@export var turn_rate: float = 6.0

func _init():
	behavior_name = "Homing"
	description = "Targets a creature and steers toward it."

func on_tick(projectile, delta):
	var target = projectile.target
	if target == null:
		return

	# direction to target
	var to_target = target.global_position - projectile.global_position
	if to_target.length() == 0:
		return

	var desired = to_target.normalized() * projectile.speed

	# smooth steering
	projectile.velocity = projectile.velocity.lerp(
		desired,
		turn_rate * delta
	)
