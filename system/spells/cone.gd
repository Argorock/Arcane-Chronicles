extends Node2D
class_name ConeSpell

var stats: Dictionary

func apply_stats(stats_: Dictionary) -> void:
	stats = stats_
	if has_node("Polygon2D") and stats.has("element_color"):
		$Polygon2D.color = stats.element_color

func _process(delta):
	if not is_inside_tree():
		return

	var caster = get_parent()  # or store reference
	var target = caster.get_global_mouse_position()

	global_position = caster.global_position
	look_at(target)

	# scaling handled by casting system or here
