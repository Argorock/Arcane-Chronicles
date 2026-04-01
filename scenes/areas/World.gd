extends Node2D

var current_door = null
var initialized := false

func _ready():
	await get_tree().process_frame
	initialized = true
	for door in get_tree().get_nodes_in_group("doors"):
		door.player_entered.connect(_on_door_entered)
		door.player_exited.connect(_on_door_exited)
		


func _process(delta):
	if get_tree().current_scene != self:
		return
	if current_door and Input.is_action_just_pressed("ui_accept"):
		_enter_door(current_door)


func _enter_door(door):
	var tree := get_tree()
	var old_scene := tree.current_scene
	var player := old_scene.get_node("Player")

	# 1. Detach player BEFORE scene change
	old_scene.remove_child(player)
	tree.root.add_child(player)

	# 2. Change scene
	if door.target_scene:
		GameState.return_scene_path = old_scene.scene_file_path
		tree.change_scene_to_packed(door.target_scene)
	else:
		var packed := load(GameState.return_scene_path)
		tree.change_scene_to_packed(packed)

	# 3. Wait until the new scene is fully ready
	await tree.process_frame
	var new_scene := tree.current_scene
	await new_scene.ready

	# 4. Move player to spawn point if it exists
	var spawn := new_scene.get_node_or_null("SpawnPoint")
	if spawn:
		player.global_position = spawn.global_position

	# 5. Reattach player to the new scene
	new_scene.add_child(player)
	
	

func _on_door_entered(door):
	current_door = door

func _on_door_exited(door):
	if current_door == door:
		current_door = null
		


