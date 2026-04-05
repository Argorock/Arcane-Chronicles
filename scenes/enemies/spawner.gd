extends Node2D

@export var creature_scene: PackedScene
@export var spawn_interval := 3.0
@export var max_alive := 10
@export var spawn_radius := 200.0
@export var activation_range := 200.0

var timer := 0.0
var alive := []
var spawn_multiplier := 1.0        # grows over time
var spawn_increase := 0.05         # how fast difficulty ramps
var max_spawn_per_wave := 5        # safety cap

func _process(delta):
	timer -= delta
	if timer <= 0:
		timer = spawn_interval
		_try_spawn()

func _try_spawn():
	var players = get_tree().get_nodes_in_group("player")
	if players.is_empty():
		return

	var player = players[0]

	if global_position.distance_to(player.global_position) > activation_range:
		return

	# Clean the alive list properly
	alive = alive.filter(func(e):
		return e != null and is_instance_valid(e) and e.alive and e.get_parent() == get_tree().current_scene)

	if alive.size() >= max_alive:
		return

	# Increase difficulty each time we spawn
	spawn_multiplier += spawn_increase

	# Compute how many creatures to spawn this wave
	var spawn_count = int(round(spawn_multiplier))
	spawn_count = clamp(spawn_count, 1, max_spawn_per_wave)

	for i in range(spawn_count):
		# Stop if we hit max_alive
		if alive.size() >= max_alive:
			break

		var creature = UniversalPool.get_creature(creature_scene)
		creature.creature_scene = creature_scene
		creature.reset_state()

		# Try multiple random positions until one is safe
		var spawn_pos = Vector2.ZERO
		var tries = 12

		while tries > 0:
			var offset = Vector2(
				randf_range(-spawn_radius, spawn_radius),
				randf_range(-spawn_radius, spawn_radius)
			)

			spawn_pos = global_position + offset

			if _is_position_safe(spawn_pos, creature):
				break

			tries -= 1

		creature.global_position = spawn_pos
		get_tree().current_scene.add_child(creature)

		alive.append(creature)
	
func _is_position_safe(pos: Vector2, creature: Node) -> bool:
	var space = get_world_2d().direct_space_state

	# Get the bat's main collision shape
	var shape: CollisionShape2D = creature.get_node("CollisionShape2D")
	if shape == null or shape.shape == null:
		return true  # fail-safe: assume safe

	var params = PhysicsShapeQueryParameters2D.new()
	params.shape = shape.shape
	params.transform = Transform2D(0, pos)
	params.collide_with_areas = false
	params.collide_with_bodies = true

	var result = space.intersect_shape(params, 1)
	return result.is_empty()
