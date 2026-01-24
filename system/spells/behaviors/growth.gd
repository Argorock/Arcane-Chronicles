extends BehaviorData

@export var growth_rate: float = 0.5

func _init():
	behavior_name = "Growth"
	description = "spell grows in size as it travels"
	
func on_tick(spell, delta):
	spell.area_radius += growth_rate * delta
	
