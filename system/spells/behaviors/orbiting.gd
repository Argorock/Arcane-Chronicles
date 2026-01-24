extends BehaviorData

@export var orbit_count: int = 4
@export var orbit_radius: float = 1.5
@export var orbit_speed: float = 2.0

var orbiters = []

func _init():
	behavior_name = "Orbiting"
	description = "creates orbiting projectiles around the spell point"
	
func on_spawn(spell):
	for i in range(orbit_count):
		var orb = spell.spawn_orbiter()
		orb.orbit_angle = (TAU / orbit_count) * i
		orbiters.append(orb)
			
func on_tick(spell, delta):
	for orb in orbiters:
		orb.orbit_angle += orbit_speed * delta
		orb.global_position = spell.global_position + Vector2(
			cos(orb.orbit_angle),
			sin(orb.orbit_angle)
		) * orbit_radius
	
	
