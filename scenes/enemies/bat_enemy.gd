extends CharacterBody2D

@export var float_speed := 40.0
@export var attack_speed := 120.0
@export var detection_range := 200.0
@export var max_health := 20
@export var respawn_delay := 2.0
@export var spawn_count := 2

var health: int
var player : CharacterBody2D = null
var attacking := false
var horizontal_dir := 1
var change_dir_timer := 0.0

func _ready():
	$AnimatedSprite2D.play("idlefly")
	$DetectionArea.body_entered.connect(_on_body_entered)
	$DetectionArea.body_exited.connect(_on_body_exited)
	$Hitbox.body_entered.connect(_on_hitbox_entered)
	randomize()
	
func _physics_process(delta):
	if attacking and player:
		_attack_player(delta)
	else:
		_random_fly(delta)
		
func _random_fly(delta):
	change_dir_timer -= delta
	if change_dir_timer <= 0:
		horizontal_dir = randf_range(-1.0, 1.0)
		change_dir_timer = randf_range(1.0, 3.0)
		
	var vertical = sin(Time.get_ticks_msec() / 200.0)
	velocity = Vector2(horizontal_dir * float_speed, vertical * float_speed)
	move_and_slide()
	
func _attack_player(delta):
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * attack_speed
	move_and_slide()
	
func _on_hitbox_entered(body):
	if body.is_in_group("player"):
		body.take_damage(10)
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		player = body
		attacking = true
		
func _on_body_exited(body):
	if body == player:
		player = null
		attacking = false
		
func take_damage(amount):
	health -= amount
	if health <= 0:
		die()
		
func die():
	visible = false
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	
	get_tree().create_timer(respawn_delay).timeout.connect(_spawn_more)
	
func _spawn_more():
	var parent = get_parent()
	for i in range(spawn_count):
		var new_bat = self.duplicate()
		new_bat.global_position = global_position + Vector2(randf_range(-50, 50), randf_range(-50, 50))
		parent.add_child(new_bat)
		
	queue_free()
	
