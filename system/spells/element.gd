extends Resource
class_name ElementData

@export var element_name: String = "Unnamed"
@export var color: Color = Color.WHITE
@export var icon: Texture2D = null

#		modifiers
@export var damage_multiplier: float = 1.0
@export var speed_multiplier: float = 1.0
@export var range_multiplier: float = 1.0
@export var cooldown_multiplier: float = 1.0
@export var mana_cost_multiplier: float = 1.0

@export var status_chance: float = 0.0
