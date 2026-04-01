extends BehaviorData
class_name GrowthBehavior

@export var growth_rate: float = 0.5

func _init():
	behavior_name = "Growth"
	description = "Spell grows in size as it travels."

func on_tick(projectile, delta):
	projectile.area_radius += growth_rate * delta
