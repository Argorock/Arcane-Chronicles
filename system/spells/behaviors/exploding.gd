extends BehaviorData
class_name ExplodingBehavior

@export var explosion_radius: float = 3.0
@export var explosion_damage: float = 20.0
@export var explosion_interval: float = 0.5

var time_accum := 0.0

func _init():
	behavior_name = "Exploding"
	description = "Spell explodes periodically as it travels."

func on_tick(projectile, delta):
	time_accum += delta
	if time_accum >= explosion_interval:
		time_accum = 0.0
		_explode(projectile)

func _explode(projectile):
	var enemies = projectile.get_entities_in_radius(projectile.global_position, explosion_radius)
	for e in enemies:
		e.apply_damage(explosion_damage)
