extends Node2D

var spell
var caster
var stats
var element_color: Color

func setup(spell, caster, target_pos, stats):
	self.spell = spell
	self.caster = caster
	self.stats = stats
	element_color = spell.element.color

	# assign sprite if scene has one
	var ct = spell.casting_type
	if has_node("Sprite2D") and ct.sprite_texture:
		$Sprite2D.texture = ct.sprite_texture

	apply_color()
	_on_setup(target_pos)

func apply_color():
	for child in get_children():
		if child is Sprite2D:
			child.modulate = element_color
		if child is Line2D:
			child.default_color = element_color

func _on_setup(target_pos: Vector2) -> void:
	pass
