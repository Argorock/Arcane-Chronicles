extends BehaviorData
class_name LatchingBehavior

@export var tick_interval: float = 0.5
@export var tick_damage: float = 4.0
@export var latch_duration: float = 3.0

func _init():
	behavior_name = "Latching"
	description = "Attaches to a target and damages over time."

func on_hit(projectile, target):
	projectile.should_destroy_on_hit = false
	projectile.attach_to(target, tick_interval, tick_damage, latch_duration)
