extends BehaviorData
class_name SplinterShotBehavior

@export var shard_count: int = 3
@export var shard_spread: float = 45.0

func _init():
	behavior_name = "Splinter Shot"
	description = "Spell splits into multiple smaller projectiles on hit."

func on_hit(projectile: Node2D, target) -> void:
	var caster = projectile.caster
	var spell = projectile.spell
	var stats: Dictionary = spell.get_final_stats()

	var base_dir: Vector2 = projectile.velocity.normalized()
	var half: float = (shard_count - 1) * 0.5

	for i in range(shard_count):
		var t: float = float(i) - half
		var angle: float = deg_to_rad(t * shard_spread)
		var dir: Vector2 = base_dir.rotated(angle)

		# Spawn child projectile at the hit location
		projectile.get_parent()._spawn_projectile(
			spell,
			caster,
			projectile.global_position,
			dir,
			stats
		)
