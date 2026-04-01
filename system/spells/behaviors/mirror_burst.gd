extends BehaviorData
class_name MirrorBurstBehavior

func _init():
	behavior_name = "Mirror-burst"
	description = "Casts a mirrored version of the spell back toward the caster."

func on_spawn(projectile):
	if projectile.caster == null or projectile.end_point == null:
		return

	var mirror = projectile.spawn_child_projectile()
	mirror.global_position = projectile.end_point
	var dir = (projectile.caster.global_position - projectile.end_point).normalized()
	mirror.velocity = dir * mirror.speed
