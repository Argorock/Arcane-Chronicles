extends BehaviorData
class_name SpreadBehavior

@export var extra_spread: float = 15.0

func _init():
	behavior_name = "Spread"
	description = "Increases spread angle of multi‑projectile casting types."

func on_spawn(projectile: Node2D) -> void:
	# Your casting types use `spread_degrees`
	if projectile.has_variable("spread_degrees"):
		projectile.spread_degrees += extra_spread
