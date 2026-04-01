extends BehaviorData
class_name AreaOfEffectBehavior

@export var damage: float = 20.0
@export var tick_interval: float = 0.2
@export var alpha: float = 0.25

var time_accum: float = 0.0
var ring: AoeRing

func _init():
	behavior_name = "Area of Effect"
	description = "Creates a persistent AOE around the spell while it travels."

func on_spawn(projectile):
	print("AOE: on_spawn")
	ring = AoeRing.new()
	ring.radius = 64
	var base_color: Color = projectile.element_color
	var final_color: Color = Color(base_color.r, base_color.g, base_color.b, alpha)
	ring.color = final_color
	ring.z_index = 999
	projectile.add_child(ring)

func on_tick(projectile, delta):
	print("AOE: on_tick")
	time_accum += delta
	if time_accum < tick_interval:
		return
	time_accum = 0.0

	var enemies = projectile.get_entities_in_radius(
		projectile.global_position,
		projectile.area_radius
	)
	for e in enemies:
		if e == projectile.caster:
			continue
		if not e.has_method("apply_damage"):
			continue
		e.apply_damage(damage)

func on_expire(projectile):
	if ring:
		if is_instance_valid(ring):
			ring.queue_free()
	ring = null


class AoeRing:
	extends Node2D

	var radius: float = 32.0
	var color: Color = Color(0, 1, 0, 0.4)

	func _process(delta):
		queue_redraw()

	func _draw():
		draw_circle(Vector2.ZERO, radius, color)
