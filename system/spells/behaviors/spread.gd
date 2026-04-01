extends BehaviorData
class_name SpreadBehavior

@export var extra_spread: float = 15.0

func _init():
	behavior_name = "Spread"
	description = "Increases spread angle of multi‑projectile casting types."

func on_spawn(projectile):
	projectile.spread_angle += extra_spread
