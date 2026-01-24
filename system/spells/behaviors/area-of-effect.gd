extends BehaviorData

@export var aoe_multiplier: float = 1.5

func _init():
	behavior_name = "Area of Effect"
	description = "Increases the area effected by a spell"
	
func on_spawn(spell):
	spell.area_radius *= aoe_multiplier
	
