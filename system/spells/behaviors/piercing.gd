extends BehaviorData
class_name PiercingBehavior

@export var extra_pierces: int = 1

func _init():
	behavior_name = "Piercing"
	description = "Increases the base pierce of the spell."

func on_spawn(projectile):
	projectile.max_pierces += extra_pierces
