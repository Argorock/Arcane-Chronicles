extends Node2D


var current_door: Area2D = null

func _process(delta):
	if current_door == $GuildBuilding/GuildDoorZone and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/areas/World.tscn")
	elif current_door and Input.is_action_just_pressed("ui_accept"):
		_enter_door(current_door)
	

func _enter_door(door):
	GameState.return_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(door.target_scene)
	

func _on_library_door_zone_body_entered(body):
	if body.name == "Player":
		current_door = $LibraryBuilding/LibraryDoorZone

func _on_library_door_zone_body_exited(body):
	if body.name == "Player":
		current_door = null


func _on_guild_door_zone_body_entered(body):
	if body.name == "Player":
		current_door = $GuildBuilding/GuildDoorZone


func _on_guild_door_zone_body_exited(body):
	if body.name == "Player":
		current_door = null
