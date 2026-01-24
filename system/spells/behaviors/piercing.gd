extends BehaviorData

func _init():
	behavior_name = "Piercing"
	description = "Allows spell to pass through more targets"
	
func on_hit(spell, target):
	spell.should_destroy_on_hit = false
