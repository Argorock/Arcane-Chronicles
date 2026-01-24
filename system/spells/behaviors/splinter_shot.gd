extends BehaviorData

@export var split_count: int = 5
@export var split_spread: float = 45.0


func _init():
	behavior_name = "Splinter Shot"
	description = "spell splits mid air"
	
func on_expire(spell):
	for i in range(split_count):
		var angle = deg_to_rad(randf_range(-split_spread, split_spread))
		var new_proj = spell.spawn_child_porjectile()
		new_proj.velocity = spell.veleocity.rotated(angle)
		
