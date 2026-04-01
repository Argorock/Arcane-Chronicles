extends Node
class_name PlayerSpellCaster

@export var spell_casting: SpellCasting

var current_spell: SpellData = null
var cooldown: float = 0.0

func _process(delta: float) -> void:
	if cooldown > 0.0:
		cooldown -= delta

	if Input.is_action_just_pressed("cast_spell"):
		_try_cast()


func _try_cast() -> void:
	print("PlayerSpellCaster: casting", current_spell)
	if current_spell == null:
		return

	if cooldown > 0.0:
		return

	var target_pos: Vector2 = owner.get_global_mouse_position()
	spell_casting.cast_spell(current_spell, owner, target_pos)

	var stats = current_spell.get_final_stats()
	cooldown = stats.cooldown


func set_spell(spell: SpellData) -> void:
	current_spell = spell
