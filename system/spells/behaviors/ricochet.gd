extends BehaviorData

@export var max_bounces: int = 3

func _init():
	behavior_name = "Ricochet"
	description = "Projectile bounces of surfaces"
	
func on_impact(spell, position):
	if spell.bounce_count < max_bounces:
		spell.bounce_count += 1
		spell.velocity = spell.velocity.bounce(spell.last_normal)
	else: 
		spell.queue_free()
	
