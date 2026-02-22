extends CharacterBody2D

@export var speed := 200
@export var jump_force := -350
@export var gravity := 900
@export var max_health := 100
@export var fireball: PackedScene

var health: int
var facing_right := true

func _ready():
	health = max_health

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
	if fireball == null:
		return

	var spell = fireball.instantiate()
	spell.global_position = global_position

	var mouse_pos = get_global_mouse_position()
	spell.direction = (mouse_pos - global_position).normalized()

	get_tree().current_scene.add_child(spell)

func take_damage(amount):
	health -= amount
	print("Player health:", health)

	if health <= 0:
		die()

func die():
	print("Game Over")
	get_tree().reload_current_scene()
