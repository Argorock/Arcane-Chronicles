extends BehaviorData
class_name ScatterShotBehavior

@export var extra_projectiles: int = 2
@export var extra_spread: float = 10.0

func _init():
	behavior_name = "Scatter Shot"
	description = "Increases projectile count at the cost of more spread."

func on_spawn(projectile):
	projectile.projectile_count += extra_projectiles
	projectile.spread_angle += extra_spread
