extends BehaviorData
class_name SplinterShotBehavior

@export var split_count: int = 5
@export var split_spread: float = 45.0

func _init():
	behavior_name = "Splinter Shot"
	description = "Spell splits mid‑air."

func on_expire(projectile):
	for i in range(split_count):
		var angle = deg_to_rad(randf_range(-split_spread, split_spread))
		var new_proj = projectile.spawn_child_projectile()
		new_proj.velocity = projectile.velocity.rotated(angle)
