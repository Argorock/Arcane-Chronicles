extends Node2D
class_name Door

@export var target_scene: PackedScene

signal player_entered(door)
signal player_exited(door)

@onready var trigger := $DoorZone
@onready var anim: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")

func _ready():
	# Connect trigger signals safely
	if not trigger.body_entered.is_connected(_on_door_zone_body_entered):
		trigger.body_entered.connect(_on_door_zone_body_entered)

	if not trigger.body_exited.is_connected(_on_door_zone_body_exited):
		trigger.body_exited.connect(_on_door_zone_body_exited)

	# Add to group so Guild can find it
	add_to_group("doors")

func _on_door_zone_body_entered(body):
	if body.name == "Player":
		player_entered.emit(self)

func _on_door_zone_body_exited(body):
	if body.name == "Player":
		player_exited.emit(self)

# ---------------------------------------------------------
# NEW: Door handles its own animation + scene transition
# ---------------------------------------------------------
func try_enter():
	# Play animation if present
	if anim and anim.has_animation("door"):
		anim.play("door")
		await anim.animation_finished

	# Scene transition logic
	if target_scene:
		GameState.return_scene_path = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_packed(target_scene)
	else:
		if GameState.return_scene_path != "":
			var packed := load(GameState.return_scene_path)
			get_tree().change_scene_to_packed(packed)
		else:
			print("Door has no target_scene and no return_scene_path")
