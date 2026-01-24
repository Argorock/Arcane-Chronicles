@icon("res://icons/spell_icon.png")
extends Resource
class_name Spell

# Enums
const Element = preload("res://spells/element.gd")
const CastingType = preload("res://spells/casting_type.gd")
const Behavior = preload("res://spells/behavior.gd")
const Utility = preload("res://spells/utility.gd")

#		Spell Name
@export var spell_name: String = "Unnamed Spell"

#		Element type
@export var element: Element = Element.NONE

#		Casting Tyoe
@export var casting_type: CastingType = CastingType.SINGLESHOT

#		Base Stats

@export var mana_cost: float = 10.0
@export var cast_time: float = 0.5
@export var cooldown: float = 1.0
@export var range: float = 10.0
@export var speed: float = 20.0
@export var damage: float = 20.0

#		Behaviors
@export var behaviors: Array[Behavior] = []
@export var utilities: Array[Utility] = []

@export var visuals: PackedScene = null
@export var audio: AudioStream = null

#		lets you add a id and description to a spell
@export var spell_id: string = ""
@export var description: string = ""

#		gives a setable limit to the number of Attributes
@export var attributes: Array[Attribute] = []


#		Allows for special spell overrides
@export var runtime_script: Script = null

#		UI Icon
@export var icon: Texture2D = null
