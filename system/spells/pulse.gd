extends Node2D
class_name PulseSpell

var stats: Dictionary
var radius := 8.0
var max_radius := 0.0
var growth_speed := 0.0

func setup(spell, caster: Node2D, spawn_pos: Vector2, dir: Vector2, s: Dictionary) -> void:
	stats = s
	global_position = caster.global_position
	radius = 0.0
	max_radius = float(stats.range)
	growth_speed = float(stats.speed)
	_update_ring()
	
func _physics_process(delta: float) -> void:
	radius += growth_speed * delta

	if radius >= max_radius:
		queue_free()
		return
		print("radius:", radius)

	_update_ring()
	
func _update_ring() -> void:
	var line := $Line2D
	line.clear_points()

	var segments := 64
	for i in range(segments + 1): # +1 closes the circle
		var angle := TAU * float(i) / float(segments)
		var p := Vector2(cos(angle), sin(angle)) * radius
		line.add_point(p)

	if stats.has("element_color"):
		line.default_color = stats.element_color
