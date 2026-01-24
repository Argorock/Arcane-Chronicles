extends CharacterBody2D

@export var speed := 200
@export var jump_force := -350
@export var gravity := 900
@export var spell_scene: PackedScene

var facing_right := true

func _physics_process(delta):
	velocity.x = 0
	
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		facing_right = false
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
		facing_right = true
		
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
		
	move_and_slide()
	
	if Input.is_action_just_pressed("cast_spell"):
		cast_spell()
		
func cast_spell():
	if spell_scene == null:
		return
		
	var offset_x := 16 if facing_right else -16
	var dir := Vector2.RIGHT if facing_right else Vector2.LEFT
	
	var spell = spell_scene.instantiate()
	spell.global_position = global_position + Vector2(offset_x, -8)
	spell.direction = dir
	get_tree().current_scene.add_child(spell)
