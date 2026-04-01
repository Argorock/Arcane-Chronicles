extends CharacterBody2D

@export var speed := 200
@export var jump_force := -350
@export var gravity := 900
@export var max_health := 100


@export var spell_casting: SpellCasting
var current_spell: SpellData

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

	if Input.is_action_pressed("cast_spell"):
		cast_spell()
	else:
		spell_casting.is_casting = false


func cast_spell():
	if current_spell == null:
		return

	var mouse_pos := get_global_mouse_position()
	spell_casting.cast_spell(current_spell, self, mouse_pos)

func take_damage(amount):
	health -= amount
	print("Player health:", health)

	if health <= 0:
		die()

func die():
	print("Game Over")
	get_tree().reload_current_scene()
	
