extends Node2D
class_name Projectile

var spell: SpellData
var caster: Node2D

var dir: Vector2 = Vector2.ZERO
var speed: float = 0.0
var damage: float = 0.0
var area_radius: float = 0.0
var element_color: Color = Color.WHITE

var gravity_enabled: bool = false
var homing_enabled: bool = false
var undodgeable: bool = false

var behaviors: Array = []
var velocity: Vector2 = Vector2.ZERO
var lifetime: float = 3.0
var max_distance: float = 500.0
var start_position: Vector2
var end_point: Vector2 = Vector2.ZERO


func setup(
		spell_: SpellData,
		caster_: Node2D,
		spawn_pos: Vector2,
		dir_: Vector2,
		stats: Dictionary
	) -> void:

	spell = spell_
	caster = caster_
	global_position = spawn_pos
	start_position = spawn_pos

	# HARD APPLY projectile scale (Rain = 0.2)
	scale = Vector2.ONE * spell.casting_type.projectile_scale

	# copy behaviors
	behaviors = []
	for b in spell_.behaviors:
		behaviors.append(b)

	dir = dir_.normalized()
	speed = stats.speed
	damage = stats.damage
	max_distance = stats.range

	# area radius
	if stats.has("area_radius"):
		area_radius = stats.area_radius
	else:
		area_radius = 0.0

	# flags
	gravity_enabled = stats.get("gravity_enabled", spell.casting_type.gravity_enabled)
	homing_enabled = spell.casting_type.homing_enabled
	undodgeable = spell.casting_type.undodgeable

	velocity = dir * speed

	# element color
	element_color = stats.get("element_color", spell.element.color)

	# apply color WITHOUT affecting size
	if has_node("Sprite2D"):
		$Sprite2D.self_modulate = element_color
		$Sprite2D.scale = Vector2.ONE  # lock sprite scale

	# run behavior spawn hooks
	for b in behaviors:
		b.on_spawn(self)


func _ready():
	end_point = get_global_mouse_position()


func _physics_process(delta: float) -> void:
	for b in behaviors:
		b.on_tick(self, delta)

	if homing_enabled and caster and caster.has_method("get_target"):
		var target: Node2D = caster.get_target()
		if target:
			var desired: Vector2 = (target.global_position - global_position).normalized()
			velocity = velocity.lerp(desired * speed, 0.1)

	if gravity_enabled:
		velocity.y += 600.0 * delta

	global_position += velocity * delta

	if global_position.distance_to(start_position) > max_distance:
		for b in behaviors:
			b.on_expire(self)
		queue_free()
		return

	lifetime -= delta
	if lifetime <= 0.0:
		for b in behaviors:
			b.on_expire(self)
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body == caster:
		return

	for b in behaviors:
		b.on_hit(self, body)

	if body.has_method("apply_damage"):
		body.apply_damage(damage)

	if not undodgeable:
		for b in behaviors:
			b.on_expire(self)
		queue_free()


func get_entities_in_radius(center: Vector2, radius: float) -> Array:
	var space_state = get_world_2d().direct_space_state

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = CircleShape2D.new()
	query.shape.radius = radius
	query.transform = Transform2D(0, center)

	var results = space_state.intersect_shape(query)
	var entities: Array = []

	for r in results:
		if r.collider and r.collider != self:
			entities.append(r.collider)

	return entities
