extends BehaviorData
class_name RepellingBehavior

@export var repel_radius: float = 3.0
@export var repel_force: float = 200.0

func _init():
	behavior_name = "Repelling"
	description = "Repels entities and objects away from the spell."

func on_tick(projectile, delta):
	var entities = projectile.get_entities_in_radius(projectile.global_position, repel_radius)
	for e in entities:
		var dir = (e.global_position - projectile.global_position).normalized()
		e.apply_force(dir * repel_force * delta)
