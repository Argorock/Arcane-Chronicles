extends BehaviorData
class_name BouncingBehavior

@export var max_bounces: int = 4

func _init():
	behavior_name = "Bouncing"
	description = "Bounces off objects until it hits an entity or runs out of bounces."

func on_impact(projectile, position):
	if projectile.bounce_count < max_bounces:
		projectile.bounce_count += 1
		projectile.velocity = projectile.velocity.bounce(projectile.last_normal)
	else:
		projectile.queue_free()

func on_hit(projectile, target):
	projectile.queue_free()
