extends Control



func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scenes/areas/WorldCreation.tscn")


func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://scenes/areas/World.tscn")


func _on_multiplayer_pressed():
	get_tree().change_scene_to_file("res://scenes/areas/MultiplayerMenu.tscn")
