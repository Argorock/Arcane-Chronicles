extends BehaviorData
class_name OrbitingBehavior

@export var orbit_count: int = 4
@export var orbit_radius: float = 1.5
@export var orbit_speed: float = 2.0

var orbiters: Array = []

func _init():
	behavior_name = "Orbiting"
	description = "Creates orbiting projectiles around the spell."

func on_spawn(projectile):
	for i in range(orbit_count):
		var orb = projectile.spawn_orbiter()
		orb.orbit_angle = (TAU / orbit_count) * i
		orbiters.append(orb)

func on_tick(projectile, delta):
	for orb in orbiters:
		orb.orbit_angle += orbit_speed * delta
		orb.global_position = projectile.global_position + Vector2(
			cos(orb.orbit_angle),
			sin(orb.orbit_angle)
		) * orbit_radius
