extends BehaviorData
class_name AbsorbingBehavior

@export var pull_radius: float = 3.0
@export var pull_force: float = 200.0

func _init():
	behavior_name = "Absorbing"
	description = "Pulls entities and objects toward the spell."

func on_tick(projectile, delta):
	var entities = projectile.get_entities_in_radius(projectile.global_position, pull_radius)
	for e in entities:
		var dir = (projectile.global_position - e.global_position).normalized()
		e.apply_force(dir * pull_force * delta)
