extends BehaviorData

@export var extra_spread: float = 15.0

func _init():
	behavior_name = "Spread"
	description = "Increases spread angle of multi-porjectile casting types"
	
	
func on_spawn(spell):
	spell.spread_angle += extra_spread
