extends Control

func _on_exit_pressed() -> void:
	if GameState.return_scene_path != "":
		get_tree().change_scene_to_file(GameState.return_scene_path)
	else:
		get_tree().change_scene_to_file("res://scenes/areas/MainMenu.tscn")

	
var can_use_table = false
func _on_table_body_entered(body):
	if body.name == "Player":
		can_use_table = true
func _on_table_body_exited(body):
	if body.name == "Player":
		can_use_table = false
		



var can_exit = false

func _on_door_body_entered(body):
	if body.name == "Player":
		can_exit = true

func _on_door_body_exited(body):
	if body.name == "Player":
		can_exit = false

func _process(delta):
	if can_use_table and Input.is_action_just_pressed("ui_accept"):
		$CanvasLayer/SpellUi.visible = true
	if not can_use_table:
		$CanvasLayer/SpellUi.visible = false
	if can_exit and Input.is_action_just_pressed("ui_accept"):
		_on_exit_pressed()


@onready var casting_box = $CanvasLayer/SpellUi/Panel/HBoxContainer/TabContainer/CastingTab/ScrollContainer/GridContainer
@onready var element_box = $CanvasLayer/SpellUi/Panel/HBoxContainer/TabContainer/ElementsTab/ScrollContainer/GridContainer
@onready var behavior_box = $CanvasLayer/SpellUi/Panel/HBoxContainer/TabContainer/BehaviorTab/ScrollContainer/GridContainer

const SpellAttributes = preload("res://system/spells/spell_attributes.gd")
var SpellButton = preload("res://scenes/spells/button.tscn")


# creates the buttons dynamically by calling all the different attributes in attribute list
func build_buttons(list, container, single_choice = false):
	for item in list:
		var btn = SpellButton.instantiate()
		btn.text = item
		if single_choice:
			btn.toggle_mode = true
			btn.connect("pressed", Callable(self, "on_single_choice_pressed").bind(btn, container))
		else:
			btn.toggle_mode = true
			btn.connect("pressed", Callable(self, "on_multi_select_pressed").bind(btn))
		container.add_child(btn)
		
func on_single_choice_pressed(btn, container):
	for child in container.get_children():
		if child != btn:
			child.button_pressed = false
func on_multi_select_pressed():
	pass

func _ready():
	$CanvasLayer/SpellUi.visible = false
	build_buttons(SpellAttributes.casting_types, casting_box, true)
	build_buttons(SpellAttributes.elements, element_box, true)
	build_buttons(SpellAttributes.behaviors, behavior_box, false)




