extends Node2D

var current_door: Door = null
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
		current_door.try_enter()

func _on_door_entered(door):
	current_door = door

func _on_door_exited(door):
	if current_door == door:
		current_door = null
