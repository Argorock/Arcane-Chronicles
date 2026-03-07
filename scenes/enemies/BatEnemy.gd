extends CharacterBody2D

@export var float_speed := 40.0
@export var attack_speed := 120.0
@export var detection_range := 200.0
@export var max_health := 50
@export var sleep_distance := 1200.0
@export var damage_per_tick := 5
@export var tick_rate := 1.0
@export var ai_distance := 200.0
@export var creature_scene: PackedScene

var player: CharacterBody2D = null
var health := 0
var attacking := false
var damage_cooldown := 0.0

var horizontal_dir := 1.0
var vertical := 0.0
var float_phase := 0.0
var change_dir_timer := 0.0

var ai_timer := 0.0
var wall_follow_dir := Vector2.ZERO

var last_seen_position := Vector2.ZERO
var search_timer := 0.0
var state := "idle"

var alive := false

func _ready():
	$DetectionArea.body_entered.connect(_on_body_entered)
	$DetectionArea.body_exited.connect(_on_body_exited)
	$Hitbox.body_entered.connect(_on_hitbox_entered)
	$Hitbox.body_exited.connect(_on_hitbox_exited)

	var shape = $DetectionArea/CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius = detection_range
	elif shape is RectangleShape2D:
		shape.extents = Vector2(detection_range, detection_range)

	reset_state()

func reset_state():
	alive = true
	visible = true

	health = max_health
	attacking = false
	damage_cooldown = 0.0
	player = null

	horizontal_dir = 1.0
	vertical = 0.0
	float_phase = 0.0
	change_dir_timer = 0.0
	ai_timer = 0.0
	wall_follow_dir = Vector2.ZERO
	velocity = Vector2.ZERO

	state = "idle"
	search_timer = 0.0

	$AnimatedSprite2D.play("idlefly")

	$DetectionArea/CollisionShape2D.disabled = false
	$Hitbox/CollisionShape2D.disabled = false
	$CollisionShape2D.disabled = false

	$DetectionArea.monitoring = true
	$Hitbox.monitoring = true

	set_physics_process(true)
	set_process(true)

func _physics_process(delta):
	if not alive:
		return

	# No player → idle
	if player == null or not is_instance_valid(player):
		state = "idle"
		_idle_fly(delta)
		move_and_slide()
		return

	var dist_sq = global_position.distance_squared_to(player.global_position)

	# Too far → idle
	if dist_sq > sleep_distance * sleep_distance:
		player = null
		state = "idle"
		_idle_fly(delta)
		move_and_slide()
		return

	_float_motion(delta)

	# --- STATE MACHINE ---
	match state:

		"idle":
			if _can_see_player():
				state = "chase"
			_idle_fly(delta)
			move_and_slide()

		"chase":
			if not _can_see_player():
				state = "search"
				last_seen_position = player.global_position
				search_timer = 10.0
			else:
				_chase_player(delta)
			move_and_slide()

		"search":
			search_timer -= delta

			if _can_see_player():
				state = "chase"
				_chase_player(delta)
				move_and_slide()
				return

			if search_timer <= 0.0:
				state = "idle"
				_idle_fly(delta)
				move_and_slide()
				return

			_search_for_player(delta)
			move_and_slide()

	# Damage tick
	if attacking and player and is_instance_valid(player):
		damage_cooldown -= delta
		if damage_cooldown <= 0.0:
			damage_cooldown = tick_rate
			player.take_damage(damage_per_tick)

# -------------------------
# IDLE MOVEMENT
# -------------------------

func _idle_fly(delta):
	change_dir_timer -= delta
	if change_dir_timer <= 0.0:
		horizontal_dir = randf_range(-1.0, 1.0)
		vertical = randf_range(-1.0, 1.0)
		change_dir_timer = randf_range(1.0, 3.0)

	var dir = Vector2(horizontal_dir, vertical).normalized()

	# Smooth raycast rotation so idle doesn't lose wall awareness
	$RaycastGroup.rotation = lerp_angle($RaycastGroup.rotation, dir.angle(), 0.25)

	var avoid = _avoid_walls(dir)

	# Stronger avoidance blend for idle
	var final_dir = (dir * 0.4 + avoid * 0.6).normalized()

	velocity = final_dir * float_speed

func _float_motion(delta):
	float_phase = fmod(float_phase + delta, 2.0)
	var t := float_phase if float_phase <= 1.0 else 2.0 - float_phase
	vertical = (t * 2.0) - 1.0

# -------------------------
# CHASE MOVEMENT
# -------------------------

func _chase_player(delta):
	var to_player = player.global_position - global_position
	var dist = to_player.length()

	if dist < 1.0:
		velocity = Vector2.ZERO
		return

	var dir = to_player / dist
	var speed = attack_speed if dist >= 40.0 else lerp(0.0, attack_speed, dist / 40.0)

	$RaycastGroup.rotation = dir.angle()
	var avoid = _avoid_walls(dir)
	velocity = (dir + avoid * 2.0).normalized() * speed

# -------------------------
# SEARCH MOVEMENT
# -------------------------

func _search_for_player(delta):
	var to_last = last_seen_position - global_position

	# If close to last seen, wander
	if to_last.length() < 8.0:
		var wander = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
		$RaycastGroup.rotation = wander.angle()
		var avoid = _avoid_walls(wander)
		var final_dir = (wander * 0.8 + avoid * 0.2).normalized()
		velocity = final_dir * float_speed
		return

	# Move toward last seen position
	var dir = to_last.normalized()
	$RaycastGroup.rotation = dir.angle()

	var avoid = _avoid_walls(dir)

	# Blend: mostly toward last seen, slightly corrected by wall avoidance
	var final_dir = (dir * 0.8 + avoid * 0.2).normalized()

	velocity = final_dir * float_speed
	
	
# -------------------------
# WALL AVOIDANCE + GAPS
# -------------------------

func _avoid_walls(dir: Vector2) -> Vector2:
	var front = $RaycastGroup/WallCheckFront
	var left = $RaycastGroup/WallCheckLeft
	var right = $RaycastGroup/WallCheckRight

	# Gap detection
	if left.is_colliding() and right.is_colliding():
		var gap = _gap_width()
		if gap > 24.0:
			var center = (left.get_collision_point() + right.get_collision_point()) * 0.5
			return (center - global_position).normalized()
		return (-dir).normalized()

	# Wall sliding
	if front.is_colliding():
		var n = front.get_collision_normal()
		return _slide_along_wall(n, dir)

	if left.is_colliding():
		return Vector2.RIGHT
	if right.is_colliding():
		return Vector2.LEFT

	return Vector2.ZERO

func _gap_width() -> float:
	var left_rc = $RaycastGroup/WallCheckLeft
	var right_rc = $RaycastGroup/WallCheckRight

	if not left_rc.is_colliding() or not right_rc.is_colliding():
		return INF

	return left_rc.get_collision_point().distance_to(right_rc.get_collision_point())

func _slide_along_wall(normal: Vector2, desired: Vector2) -> Vector2:
	var slide = desired - normal * desired.dot(normal)
	return slide.normalized()

# -------------------------
# LINE OF SIGHT
# -------------------------

func _can_see_player() -> bool:
	if player == null or not is_instance_valid(player):
		return false

	var params := PhysicsRayQueryParameters2D.new()
	params.from = global_position
	params.to = player.global_position
	params.exclude = [self]
	params.collision_mask = 1  # <-- set to your wall layer

	var result = get_world_2d().direct_space_state.intersect_ray(params)

	if result.is_empty():
		return true
	return result.collider == player

# -------------------------
# SIGNALS + DAMAGE + DEATH
# -------------------------

func _on_body_entered(body):
	if alive and body is CharacterBody2D and body.is_in_group("player"):
		player = body

func _on_body_exited(body):
	if body is CharacterBody2D and body.is_in_group("player"):
		player = null
		attacking = false

func _on_hitbox_entered(body):
	if alive and body is CharacterBody2D and body.is_in_group("player"):
		attacking = true
		damage_cooldown = tick_rate
		body.take_damage(damage_per_tick * 2)

func _on_hitbox_exited(body):
	if body is CharacterBody2D and body.is_in_group("player"):
		attacking = false

func take_damage(amount):
	if not alive:
		return
	health -= amount
	if health <= 0:
		_die()

func _die():
	if not alive:
		return

	alive = false
	visible = false

	set_physics_process(false)
	set_process(false)

	$DetectionArea.monitoring = false
	$Hitbox.monitoring = false

	$DetectionArea/CollisionShape2D.disabled = true
	$Hitbox/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true

	call_deferred("_deferred_die")

func _deferred_die():
	UniversalPool.return_creature(self, creature_scene)
