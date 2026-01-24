extends BehaviorData



func _init():
	behavior_name = "Double Shot"
	description = "Fires two projectiles instead of one"
	
func on_spawn(spell):
	var proj1 = spell.spawn_child_projectile()
	var proj2 = spell.spawn_child_projectile()
	
	proj1.velocity = spell.velocity.rotated(deg_to_rad(-5))
	proj2.velocity = spell.velocity.rotated(deg_to_rad(5))
	
