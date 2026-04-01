extends BehaviorData
class_name FarShotBehavior

@export var distance: float = 5.0

func _init():
	behavior_name = "Far Shot"
	description = "Moves the origin point of the spell away from the caster."

func on_spawn(projectile):
	projectile.global_position += projectile.direction * distance
