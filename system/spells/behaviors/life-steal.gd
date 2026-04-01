extends BehaviorData
class_name LifeStealBehavior

@export var life_steal_ratio: float = 0.25

func _init():
	behavior_name = "Life-steal"
	description = "Heals the caster for a portion of damage dealt."

func on_hit(projectile, target):
	var dmg = projectile.last_damage_dealt
	if projectile.caster != null:
		projectile.caster.heal(dmg * life_steal_ratio)
