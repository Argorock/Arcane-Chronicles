extends BehaviorData
class_name PiercingBehavior

@export var pierce_count: int = 1

func _init():
	behavior_name = "Piercing"
	description = "Spell pierces through targets before dissipating."

func on_spawn(projectile):
	projectile.should_destroy_on_hit = false

func on_hit(projectile, target):
	if pierce_count > 0:
		pierce_count -= 1
	else:
		projectile.should_destroy_on_hit = true
