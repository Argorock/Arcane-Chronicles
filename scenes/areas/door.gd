extends Area2D
class_name Door

@export var target_scene: String
@export var target_door: String

signal player_entered(door)
signal player_exited(door)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_entered.emit(self)

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_exited.emit(self)
