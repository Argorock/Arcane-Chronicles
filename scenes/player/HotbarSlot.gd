#extends Control
#class_name HotbarSlot
#
#@export var slot_index: int = 0
#var spell: Spell = null
#
#func set_spell(new_spell: Spell):
	#spell = new_spell
	#if spell:
		#$Icon.texture = spell.icon
	#else:
		#$Icon.texture = null
#
#func set_cooldown(percent: float):
	## percent = 0.0 → no cooldown
	## percent = 1.0 → full cooldown
	#$CooldownOverlay.modulate.a = percent
#
#func set_selected(selected: bool):
	#$SelectionHighlight.visible = selected
#
#func set_key_label(text: String):
	#$KeyLabel.text = text
