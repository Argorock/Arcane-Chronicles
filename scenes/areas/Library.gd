extends Control
class_name Library

var ui: Control
var name_field: LineEdit
var save_button: Button
var casting_grid: GridContainer
var element_grid: GridContainer
var behavior_grid: GridContainer

var can_use_table := false

func _ready():
	ui = find_child("SpellUi", true, false)
	if ui == null:
		push_error("SpellUi not found")
		return

	name_field = ui.find_child("NameField", true, false)
	save_button = ui.find_child("SaveButton", true, false)
	casting_grid = ui.find_child("CastingGrid", true, false)
	element_grid = ui.find_child("ElementGrid", true, false)
	behavior_grid = ui.find_child("BehaviorGrid", true, false)

	if save_button:
		save_button.pressed.connect(_on_SaveButton_pressed)
		save_button.custom_minimum_size = Vector2(420, 160)
		save_button.add_theme_font_size_override("font_size", 32)

	ui.visible = false

	_build_casting_buttons()
	_build_element_buttons()
	_build_behavior_buttons()


func _process(delta):
	if can_use_table and Input.is_action_just_pressed("ui_accept"):
		ui.visible = true

	if not can_use_table:
		ui.visible = false


func _on_table_body_entered(body):
	if body.name == "Player":
		can_use_table = true

func _on_table_body_exited(body):
	if body.name == "Player":
		can_use_table = false


func _make_button(text: String, single: bool, container: Node):
	var btn := Button.new()
	btn.text = text
	btn.toggle_mode = true
	btn.custom_minimum_size = Vector2(300, 120)
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	if single:
		btn.pressed.connect(_on_single_pressed.bind(btn, container))
	else:
		btn.pressed.connect(_on_multi_pressed.bind(btn))

	container.add_child(btn)


func _build_casting_buttons():
	if casting_grid == null: return
	for c in casting_grid.get_children(): c.queue_free()
	for ct in spellregistry.casting_types:
		_make_button(ct.type_name, true, casting_grid)


func _build_element_buttons():
	if element_grid == null: return
	for c in element_grid.get_children(): c.queue_free()
	for el in spellregistry.elements:
		_make_button(el.element_name, true, element_grid)


func _build_behavior_buttons():
	if behavior_grid == null: return
	for c in behavior_grid.get_children(): c.queue_free()
	for b in spellregistry.behaviors:
		_make_button(b.behavior_name, false, behavior_grid)


func _on_single_pressed(btn: Button, container: Node):
	for child in container.get_children():
		if child != btn:
			child.button_pressed = false


func _on_multi_pressed(btn: Button):
	pass


func _build_spell() -> SpellData:
	var builder := SpellBuilder.new()
	builder.new_spell()

	builder.current_spell.name = name_field.text if name_field else "Unnamed"

	var selected_ct: CastingTypeData = null
	for btn in casting_grid.get_children():
		if btn.button_pressed:
			selected_ct = spellregistry.get_casting_type_by_name(btn.text)
			break
	if selected_ct == null:
		selected_ct = spellregistry.casting_types[0]
	builder.set_casting_type(selected_ct)

	var selected_el: ElementData = null
	for btn in element_grid.get_children():
		if btn.button_pressed:
			selected_el = spellregistry.get_element_by_name(btn.text)
			break
	if selected_el == null:
		selected_el = spellregistry.elements[0]
	builder.set_element(selected_el)

	builder.current_spell.behaviors.clear()
	for btn in behavior_grid.get_children():
		if btn.button_pressed:
			var b = spellregistry.get_behavior_by_name(btn.text)
			if b:
				builder.add_behavior(b)

	return builder.current_spell


func _on_SaveButton_pressed():
	var spell := _build_spell()

	var path := "res://spells/%s.tres" % spell.name
	ResourceSaver.save(spell, path)

	var player := get_tree().get_first_node_in_group("player")
	if player:
		var caster := player.get_node("PlayerSpellCaster")
		if caster:
			caster.set_spell(spell)
