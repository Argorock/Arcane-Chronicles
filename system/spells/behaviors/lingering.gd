extends BehaviorData
class_name LingeringBehavior

@export var drop_interval: float = 0.2
@export var linger_duration: float = 2.0
@export var linger_radius: float = 1.0

var time_accum := 0.0

func _init():
	behavior_name = "Lingering"
	description = "Leaves lingering spell effects along its path."

func on_tick(projectile, delta):
	time_accum += delta
	if time_accum >= drop_interval:
		time_accum = 0.0
		projectile.spawn_lingering_effect(
			projectile.global_position,
			linger_radius,
			linger_duration
		)
