extends Resource
class_name BehaviorData


@export var behavior_name: String = "Unnamed Behavior"
@export var description: String = ""


# 		numeric modifiers

@export var damage_multiplier: float = 1.0
@export var radius_multiplier: float = 1.0
@export var duration_multiplier: float = 1.0
@export var speed_multiplier: float = 1.0

#		flags

@export var can_pierce: bool = false
@export var can_ricochet: bool = false
@export var can_home: bool = false
@export var can_split: bool = false
@export var can_explode: bool = false


#		events

func on_spawn(spell):
	pass
	
func on_tick(spell, delta):
	pass
	
func on_hit(spell, target):
	pass
	
func on_impact(spell, position):
	pass
	
func on_expire(spell):
	pass
	
func on_trigger(spell):
	pass
	
func apply_special_rules(spell, trigger_data):
	pass
