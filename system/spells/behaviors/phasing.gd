extends BehaviorData


func _init():
	behavior_name = "Phasing"
	description = "spell passes through solid objects and terrain"
	
func apply_special_rules(spell):
	spell.ignore_walls = true
	
