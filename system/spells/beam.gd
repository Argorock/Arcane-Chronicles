extends Node2D
class_name Beam

var spell: SpellData
var caster: Node2D
var damage: float = 0.0
#var duration: float = 0.25
var stats: Dictionary

var initialized := false

func setup(spell_, caster_, target_pos, stats_):
	$Line2D.visible = false
	await get_tree().process_frame

	spell = spell_
	caster = caster_
	stats = stats_
	damage = stats.damage

	if spell.element:
		$Line2D.default_color = spell.element.color

	$Line2D.visible = true
	initialized = true


func _ready():
	position = Vector2.ZERO
	rotation = 0
	scale = Vector2.ONE

	if $Timer:
		$Timer.one_shot = true
		#$Timer.start(duration)

func _process(delta):
	if not initialized:
		return

	var target = caster.get_global_mouse_position()

	# Start at caster
	global_position = caster.global_position
	look_at(target)

	# End exactly at mouse (in local space)
	var local_target = to_local(target)
	$Line2D.points = [Vector2.ZERO, local_target]

	# Damage along the beam
	var dir = (target - caster.global_position).normalized()
	var length = local_target.length()
	_apply_beam_damage(dir, length)
	
func _apply_beam_damage(dir: Vector2, length: float):
	var space = get_world_2d().direct_space_state
	if not space:
		return

	var params = PhysicsRayQueryParameters2D.create(
		global_position,
		global_position + dir * length
	)

	var result = space.intersect_ray(params)
	if result.has("collider"):
		var collider = result["collider"]
		if collider and collider.has_method("apply_damage"):
			collider.apply_damage(damage)

func _on_timer_timeout():
	queue_free()
