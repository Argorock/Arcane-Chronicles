extends BehaviorData
class_name ConvergingBehavior

@export var converge_strength: float = 4.0

func _init():
	behavior_name = "Converging"
	description = "Projectiles curve toward the clicked point."

func on_tick(projectile, delta):
	var end_point = projectile.end_point
	if end_point == null:
		return

	var to_point = end_point - projectile.global_position
	if to_point.length() == 0:
		return

	var desired = to_point.normalized() * projectile.speed

	projectile.velocity = projectile.velocity.lerp(
		desired,
		converge_strength * delta
	)
