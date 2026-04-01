extends Node
class_name SpellBuilder

var current_spell: SpellData = null

func new_spell():
	current_spell = SpellData.new()

func set_casting_type(ct):
	var ct_copy = ct.duplicate(true)  # deep copy
	ct_copy.apply_pattern_flags()
	current_spell.casting_type = ct_copy

func set_element(el):
	current_spell.element = el

func add_behavior(b):
	current_spell.behaviors.append(b)
