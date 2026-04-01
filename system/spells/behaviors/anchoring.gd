extends BehaviorData
class_name AnchoringBehavior

func _init():
	behavior_name = "Anchoring"
	description = "Fixes the spell at point B."

func on_spawn(projectile):
	if projectile.end_point != null:
		projectile.global_position = projectile.end_point
	projectile.velocity = Vector2.ZERO
	projectile.is_anchored = true
