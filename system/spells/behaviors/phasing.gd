extends BehaviorData
class_name PhasingBehavior

func _init():
	behavior_name = "Phasing"
	description = "Spell passes through solid objects and terrain."

func on_spawn(projectile):
	projectile.set_collision_mask_value(1, false)  # disable terrain mask
	projectile.set_collision_layer_value(1, false) # disable terrain layer
	projectile.is_phasing = true
