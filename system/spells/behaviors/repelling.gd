extends BehaviorData
class_name RepellingBehavior

@export var repel_radius: float = 64.0
@export var repel_force: float = 200.0

func _init():
	behavior_name = "Repelling"
	description = "Repels entities and objects away from the spell."

func on_tick(projectile, delta):
	var entities: Array = projectile.get_entities_in_radius(
		projectile.global_position,
		repel_radius
	)

	for e in entities:
		if e == projectile.caster:
			continue

		var dir: Vector2 = (e.global_position - projectile.global_position).normalized()
		var impulse : Vector2 = dir * repel_force * delta

		# Case 1: enemy has apply_impulse()
		if e.has_method("apply_impulse"):
			e.apply_impulse(impulse)
			continue

		# Case 2: enemy has velocity property
		if e.has_variable("velocity"):
			e.velocity += impulse
			continue

		# Case 3: fallback — directly move if it's a Node2D
		if e is Node2D:
			e.global_position += impulse
