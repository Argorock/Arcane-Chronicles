extends BehaviorData
class_name ExplodingBehavior

@export var explosion_radius: float = 48.0
@export var explosion_damage: float = 1.0
@export var explosion_interval: float = 0.25
@export var explosion_offset: float = 16.0   # random offset around projectile

var timer: float = 0.0

func _init():
	behavior_name = "Exploding"
	description = "Creates small explosions along the spell's path."



func on_spawn(projectile: Node2D) -> void:
	timer = explosion_interval


func on_tick(projectile: Node2D, delta: float) -> void:
	timer -= delta
	if timer > 0.0:
		return

	timer = explosion_interval

	# typed offset + pos
	var offset: Vector2 = Vector2(
		randf_range(-explosion_offset, explosion_offset),
		randf_range(-explosion_offset, explosion_offset)
	)

	var pos: Vector2 = projectile.global_position + offset

	_spawn_explosion_ring(projectile, pos)

	# typed entities array
	var entities: Array = projectile.get_entities_in_radius(pos, explosion_radius)
	for e in entities:
		if e.has_method("apply_damage"):
			e.apply_damage(explosion_damage)


func _spawn_explosion_ring(projectile: Node2D, pos: Vector2) -> void:
	var ring := Node2D.new()
	ring.global_position = pos

	var sprite := ColorRect.new()
	sprite.color = Color(1, 0, 0, 0.25)
	sprite.size = Vector2(explosion_radius * 2.0, explosion_radius * 2.0)
	sprite.position = -sprite.size * 0.5
	sprite.mouse_filter = Control.MOUSE_FILTER_IGNORE

	ring.add_child(sprite)
	projectile.get_tree().current_scene.add_child(ring)

	var tween := ring.create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.2)
	tween.tween_callback(ring.queue_free)
