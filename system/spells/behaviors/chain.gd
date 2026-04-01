extends BehaviorData
class_name ChainBehavior

@export var chain_radius: float = 6.0
@export var max_chains: int = 4

func _init():
	behavior_name = "Chain"
	description = "Chains between clusters of nearby enemies."

func on_hit(projectile, target):
	if projectile.chain_count >= max_chains:
		return

	var candidates = projectile.get_entities_in_radius(target.global_position, chain_radius)
	candidates.erase(target)

	if candidates.is_empty():
		return

	var next = candidates[0]
	projectile.chain_count += 1
	projectile.global_position = target.global_position
	projectile.target = next
