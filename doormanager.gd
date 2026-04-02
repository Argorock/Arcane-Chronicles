extends Node
class_name DoorManager

var current_door: Node = null

func _ready():
	_register_doors(get_tree().current_scene)

func _process(delta):
	if current_door and Input.is_action_just_pressed("ui_accept"):
		_enter_door(current_door)

func _register_doors(scene: Node) -> void:
	for door in scene.get_tree().get_nodes_in_group("doors"):
		if not door.player_entered.is_connected(_on_door_entered):
			door.player_entered.connect(_on_door_entered)
		if not door.player_exited.is_connected(_on_door_exited):
			door.player_exited.connect(_on_door_exited)

func _on_door_entered(door: Node) -> void:
	current_door = door

func _on_door_exited(door: Node) -> void:
	if current_door == door:
		current_door = null

func _enter_door(door: Node) -> void:
	var tree := get_tree()
	var old_scene := tree.current_scene

	var player := tree.get_first_node_in_group("player")
	if player == null:
		return

	player.get_parent().remove_child(player)
	tree.root.add_child(player)

	var packed: PackedScene = load(door.target_scene)
	if packed == null:
		return

	tree.change_scene_to_packed(packed)

	await tree.process_frame
	var new_scene := tree.current_scene
	await new_scene.ready

	var spawn := new_scene.get_node_or_null(door.target_door)
	if spawn:
		player.global_position = spawn.global_position

	new_scene.add_child(player)
	_register_doors(new_scene)
