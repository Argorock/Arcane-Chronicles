#extends Control
#class_name HotbarUI
#
#@export var hotbar: Hotbar
#
#func _ready():
	#update_slots()
#
#func update_slots():
	#var container = $HBoxContainer
	#for i in range(container.get_child_count()):
		#var slot: HotbarSlot = container.get_child(i)
		#slot.slot_index = i
		#slot.set_spell(hotbar.slots[i])
		#slot.set_key_label(str(i + 1))
#
