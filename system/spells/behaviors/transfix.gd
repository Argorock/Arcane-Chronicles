extends BehaviorData
class_name TransfixBehavior

@export var duration: float = 2.5

func _init():
	behavior_name = "Transfix"
	description = "Roots the target in place."

func on_hit(projectile, target):
	target.apply_status("rooted", duration)
