extends Control
class_name SpellUI

signal save_pressed

func _on_save_button_pressed():
	emit_signal("save_pressed")
