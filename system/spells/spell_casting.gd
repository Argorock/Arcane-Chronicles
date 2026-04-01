extends Node
class_name SpellCasting

@export var projectile_scene: PackedScene
@export var beam_scene: PackedScene
@export var cone_scene: PackedScene
@export var pulse_scene: PackedScene
@export var wave_scene: PackedScene

# later: cone_scene, wave_scene, pulse_scene, etc.
var active_cone: Node2D = null
var is_casting := false
var active_spell: SpellData
var active_caster: Node2D
var active_target: Vector2
var active_beam: Node = null
var active_wave: Node2D = null


var cooldown := 0.0
var shots_remaining := 0

var rng := RandomNumberGenerator.new()

func cast_spell(spell: SpellData, caster: Node2D, target_pos: Vector2) -> void:
	active_spell = spell
	active_caster = caster
	active_target = target_pos
	is_casting = true

func _physics_process(delta: float) -> void:
	# Tick down cooldown
	cooldown -= delta

	# If casting stopped, kill beam and cone
	if not is_casting:
		if active_beam:
			active_beam.queue_free()
			active_beam = null

		if active_cone:
			active_cone.queue_free()
			active_cone = null
			
		if active_wave:
			active_wave.queue_free()
			active_wave = null

		return  # nothing else to do this frame


	# If casting is active, update target
	active_target = active_caster.get_global_mouse_position()

	# If still cooling down, skip this frame
	if cooldown > 0:
		return

	# --- KEY FIX: allow multiple casts per frame ---
	while cooldown <= 0:
		_perform_cast()
		cooldown += active_spell.get_final_stats().cooldown
	
	
func _perform_cast() -> void:
	var spell := active_spell
	var caster := active_caster
	var target := active_target
	var ct := spell.casting_type

	var stats := spell.get_final_stats()
	stats.element_color = spell.element.color

	match ct.persistence:

		CastingTypeData.Persistence.SEQUENTIAL:
			if shots_remaining <= 0:
				shots_remaining = ct.projectile_count

			_fire_spell(spell, caster, target, stats)
			cooldown = stats.cooldown
			shots_remaining -= 1

			if shots_remaining <= 0:
				is_casting = false
				if active_beam:
					active_beam.queue_free()
					active_beam = null

		CastingTypeData.Persistence.CONTINUOUS:
			if ct.pattern == CastingTypeData.Pattern.GATLING:
				cooldown = stats.cooldown
			else:
				cooldown = stats.cooldown

			_fire_spell(spell, caster, target, stats)

		_:
			_fire_spell(spell, caster, target, stats)
			cooldown = stats.cooldown
			is_casting = false
			
func _fire_spell(
		spell: SpellData,
		caster: Node2D,
		target_pos: Vector2,
		stats: Dictionary
	) -> void:
	var ct := spell.casting_type

	if ct.uses_beam:
		_cast_beam(spell, caster, target_pos, stats)
	elif ct.uses_cone:
		_cast_cone(spell, caster, caster.get_global_mouse_position(), stats)
	elif ct.uses_projectile:
		_cast_projectile_pattern(spell, caster, target_pos, stats, ct)
	elif ct.uses_instant_hit:
		_cast_instant(spell, caster, target_pos, stats)
# -------------------------------------------------------------------------
# PROJECTILE PATTERNS
# -------------------------------------------------------------------------

func _cast_projectile_pattern(
		spell: SpellData,
		caster: Node2D,
		target_pos: Vector2,
		stats: Dictionary,
		ct: CastingTypeData
	) -> void:

	print("PATTERN AT CAST:", ct.pattern, " TYPE:", ct.type_name)

	var spawn_pos := caster.global_position
	var base_dir := _dir_to(caster, target_pos)

	if ct.pattern == CastingTypeData.Pattern.WAVE:
		var w := wave_scene.instantiate()
		w.setup(spell, caster, spawn_pos, base_dir, stats)
		add_child(w)
		return

	match ct.pattern:
		CastingTypeData.Pattern.SINGLE:
			_spawn_projectile(spell, caster, spawn_pos, base_dir, stats)
			
		CastingTypeData.Pattern.PULSE:
			_spawn_pulse(spell, caster, stats)
			return

		CastingTypeData.Pattern.MULTI:
			_spawn_spread(spell, caster, base_dir, stats, ct.projectile_count, ct.spread_degrees, ct)

		CastingTypeData.Pattern.BURST:
			_spawn_burst_fire(spell, caster, base_dir, stats, ct.projectile_count, ct.spread_degrees, ct)

		CastingTypeData.Pattern.CASCADE:
			_spawn_spread(spell, caster, base_dir, stats, ct.projectile_count, ct.spread_degrees, ct)

		CastingTypeData.Pattern.GATLING:
			_spawn_projectile(spell, caster, spawn_pos, base_dir, stats)

		CastingTypeData.Pattern.RAIN:
			_spawn_rain(spell, caster, target_pos, stats, ct.projectile_count, ct)

		CastingTypeData.Pattern.SHOTGUN:
			_spawn_cascade(spell, caster, base_dir, stats, ct)

		CastingTypeData.Pattern.VOLLEY:
			stats.gravity_enabled = true
			_spawn_cascade(spell, caster, base_dir, stats, ct)
			

		_:
			_spawn_projectile(spell, caster, spawn_pos, base_dir, stats)
func _dir_to(caster: Node2D, target_pos: Vector2) -> Vector2:
	return (target_pos - caster.global_position).normalized()


func _spawn_pulse(spell: SpellData, caster: Node2D, stats: Dictionary) -> void:
	var p := pulse_scene.instantiate()
	print("SPAWNING PULSE:", p)
	p.setup(spell, caster, caster.global_position, Vector2.ZERO, stats)
	add_child(p)
	print("PULSE ADDED TO TREE:", p.get_parent())

func _spawn_projectile(
		spell: SpellData,
		caster: Node2D,
		spawn_pos: Vector2,
		dir: Vector2,
		stats: Dictionary
	) -> void:

	var p := projectile_scene.instantiate()
	p.setup(spell, caster, spawn_pos, dir, stats)
	add_child(p)
	
func _spawn_burst_fire(
		spell: SpellData,
		caster: Node2D,
		base_dir: Vector2,
		stats: Dictionary,
		count: int,
		spread_degrees: float,
		ct: CastingTypeData
	) -> void:

	var spawn_pos := caster.global_position
	var half := (count - 1) * 0.5
	for i in count:
		var t := i - half
		var angle := deg_to_rad(t * spread_degrees)
		var dir := base_dir.rotated(angle)
		_spawn_projectile(spell, caster, spawn_pos, dir, stats)



func _cast_cone(spell, caster, target_pos, stats):
	var ct = spell.casting_type

	if active_cone == null:
		active_cone = ct.cone_scene.instantiate()
		caster.add_child(active_cone)

		if active_cone.has_method("apply_stats"):
			active_cone.apply_stats(stats)

	active_cone.global_position = caster.global_position
	active_cone.look_at(target_pos)

	var length: float = float(stats.range) * ct.cone_length
	var width: float = ct.cone_width
	active_cone.scale = Vector2(length, width)

	_apply_cone_damage(active_cone, caster, stats)


func _apply_cone_damage(cone: Node2D, caster: Node2D, stats: Dictionary) -> void:
	var area := cone.get_node("Area2D")
	for body in area.get_overlapping_bodies():
		if body == caster:
			continue
		if body.has_method("apply_damage"):
			body.apply_damage(stats.damage)


func _apply_snap_hit(spell, caster, target_pos, stats):
	# do your damage / effect here
	# for now, just debug so you can see it works
	print("SNAP HIT at:", target_pos)


func _spawn_spread(
		spell: SpellData,
		caster: Node2D,
		base_dir: Vector2,
		stats: Dictionary,
		count: int,
		spread_degrees: float,
		ct: CastingTypeData
	) -> void:
	var spawn_pos := caster.global_position
	var half := (count - 1) * 0.5
	for i in count:
		var t := i - half
		var angle := deg_to_rad(t * spread_degrees)
		var dir := base_dir.rotated(angle)
		_spawn_projectile(spell, caster, spawn_pos, dir, stats)
		
		
func _spawn_rain(
		spell: SpellData,
		caster: Node2D,
		target_pos: Vector2,
		stats: Dictionary,
		count: int,
		ct: CastingTypeData
	) -> void:

	for i in count:
		var offset := Vector2(randf_range(-64, 64), randf_range(-128, -32))
		var spawn_pos := target_pos + offset
		var dir := Vector2.DOWN
		_spawn_projectile(spell, caster, spawn_pos, dir, stats)
	
	
	
func _spawn_cascade(
		spell: SpellData,
		caster: Node2D,
		base_dir: Vector2,
		stats: Dictionary,
		ct: CastingTypeData
	) -> void:


	var steps: int = ct.projectile_count
	var length: float = float(stats.range)

	# tighter spacing
	var step_dist: float = length * 0.005

	# start closer to caster
	var start_offset: float = 2.0

	for i in range(steps):
		var pos: Vector2 = caster.global_position + base_dir * (start_offset + step_dist * float(i))

		var angle := deg_to_rad(rng.randf_range(-ct.spread_degrees * 0.5, ct.spread_degrees * 0.5))
		var dir := base_dir.rotated(angle)

		# FIXED: use pos and dir
		_spawn_projectile(spell, caster, pos, dir, stats)
# -------------------------------------------------------------------------
# BEAM + INSTANT HIT
# -------------------------------------------------------------------------

func _cast_beam(
		spell: SpellData,
		caster: Node2D,
		target_pos: Vector2,
		stats: Dictionary
	) -> void:

	# If no beam exists, create one
	if active_beam == null:
		active_beam = beam_scene.instantiate()
		add_child(active_beam)
		active_beam.call_deferred("setup", spell, caster, target_pos, stats)
	else:
		# Update the beam's target every tick
		if active_beam.has_method("update_target"):
			active_beam.update_target(target_pos)

func _cast_instant(
		spell: SpellData,
		caster: Node2D,
		target_pos: Vector2,
		stats: Dictionary
	) -> void:
	var ct := spell.casting_type

	if ct.pattern == CastingTypeData.Pattern.SNAP:
		var max_snap_range := 24.0
		var dir := (target_pos - caster.global_position).normalized()
		target_pos = caster.global_position + dir * max_snap_range


	match spell.casting_type.pattern:

		CastingTypeData.Pattern.PULSE:
			var pulse := pulse_scene.instantiate()
			pulse.setup(spell, caster, target_pos, stats)
			add_child(pulse)

		CastingTypeData.Pattern.CONE:
			var cone := cone_scene.instantiate()
			cone.setup(spell, caster, target_pos, stats)
			add_child(cone)

		CastingTypeData.Pattern.MARK:
			var pulse := pulse_scene.instantiate()
			pulse.setup(spell, caster, target_pos, stats)
			add_child(pulse)

		CastingTypeData.Pattern.SELF:
			var pulse := pulse_scene.instantiate()
			pulse.setup(spell, caster, caster.global_position, stats)
			add_child(pulse)

		CastingTypeData.Pattern.SNAP:
			# Snap does NOT spawn a Pulse
			# It is instant-hit only
			_apply_snap_hit(spell, caster, target_pos, stats)
			
		_:
			# fallback
			var pulse := pulse_scene.instantiate()
			pulse.setup(spell, caster, target_pos, stats)
			add_child(pulse)
