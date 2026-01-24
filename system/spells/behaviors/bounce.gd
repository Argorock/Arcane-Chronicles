extends BehaviorData

@export var max_bounces: int = 5
@export var bounce_damage_multiplier: float = .5
@export var angle_variation: float = 15.0

func _init():
	behavior_name = "Bouncing"
	description = "projectile bounces off of entities, objects, and terrain"
	
func on_hit(spell, target):
	_bounce(spell, target.get_hit_normal(spell.global_position))
	
func on_impact(spell, position):
	_bounce(spell, spell.last_normal)
	
func _bounce(spell, normal):
	if spell.bounce_count >= max_bounces:
		return
	
	spell.bounce_count += 1
	spell.damage *= damage_multiplier
	var new_velocity = spell.velocity.bounce(normal)
	
	var angle = deg_to_rad(randf_range(-angle_variation, angle_variation))
	spell.velocity = new_velocity.rotated(angle)
	
