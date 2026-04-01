extends BehaviorData
class_name SuspendingBehavior

@export var suspend_duration: float = 3.0

var time_accum := 0.0

func _init():
	behavior_name = "Suspending"
	description = "Spell stops and hovers midair until hit or timed out."

func on_spawn(projectile):
	projectile.velocity = Vector2.ZERO
	projectile.is_suspended = true

func on_tick(projectile, delta):
	if not projectile.is_suspended:
		return

	time_accum += delta
	if time_accum >= suspend_duration:
		projectile.queue_free()
