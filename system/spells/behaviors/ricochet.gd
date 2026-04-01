extends BehaviorData
class_name RicochetBehavior

@export var max_bounces: int = 3

func _init():
	behavior_name = "Ricochet"
	description = "Projectile bounces off surfaces."

func on_impact(projectile, position):
	if projectile.bounce_count < max_bounces:
		projectile.bounce_count += 1
		projectile.velocity = projectile.velocity.bounce(projectile.last_normal)
	else:
		projectile.queue_free()
