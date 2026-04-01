extends Node2D
class_name WaveSpell

var stats: Dictionary
var traveled := 0.0

func setup(
		spell,
		caster: Node2D,
		spawn_pos: Vector2,
		dir: Vector2,
		s: Dictionary
	) -> void:

	stats = s
	apply_stats(s)

	global_position = spawn_pos

	if dir.length() > 0.0:
		look_at(global_position + dir)

	_center_polygon()

func _physics_process(delta: float) -> void:
	var move: Vector2 = transform.x * stats["speed"] * delta
	position += move
	traveled += move.length()

	if traveled >= stats["range"]:
		queue_free()

func apply_stats(s: Dictionary) -> void:
	stats = s
	if s.has("element_color"):
		$Polygon2D.color = s.element_color

func _center_polygon() -> void:
	var poly: Polygon2D = $Polygon2D
	var pts: PackedVector2Array = poly.polygon
	if pts.size() == 0:
		return

	var min_v: Vector2 = pts[0]
	var max_v: Vector2 = pts[0]

	for p in pts:
		min_v.x = min(min_v.x, p.x)
		min_v.y = min(min_v.y, p.y)
		max_v.x = max(max_v.x, p.x)
		max_v.y = max(max_v.y, p.y)

	var center: Vector2 = (min_v + max_v) * 0.5
	poly.position = -center
