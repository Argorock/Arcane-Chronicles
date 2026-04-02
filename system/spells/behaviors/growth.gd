extends BehaviorData
class_name GrowthBehavior

@export var growth_rate: float = 1.0

func _init():
	behavior_name = "Growth"
	description = "Spell grows in size as it travels."

func on_tick(projectile, delta):
	projectile.scale += Vector2.ONE * growth_rate * delta
