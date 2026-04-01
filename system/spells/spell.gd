extends Resource
class_name SpellData

@export var name: String = "Unnamed Spell"

# Core components
@export var element: ElementData
@export var casting_type: CastingTypeData

# Base stats (before element multipliers)
@export var base_damage: float = 10.0
@export var base_speed: float = 300.0
@export var base_range: float = 400.0
@export var base_cooldown: float = 0.5
@export var base_mana_cost: float = 10.0

# Optional: behaviors (status effects, modifiers, etc.)
@export var behaviors: Array = []

func get_final_stats() -> Dictionary:
	var stats := {}

	# Apply element multipliers
	stats.damage = base_damage * element.damage_multiplier
	stats.speed = base_speed * element.speed_multiplier
	stats.range = base_range * element.range_multiplier
	stats.cooldown = base_cooldown \
		* element.cooldown_multiplier \
		* casting_type.cooldown_multiplier
	stats.mana_cost = base_mana_cost * element.mana_cost_multiplier

	# Casting type may also modify speed
	stats.speed *= casting_type.speed_multiplier

	return stats
