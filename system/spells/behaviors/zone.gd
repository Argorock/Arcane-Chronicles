extends BehaviorData

@export var zone_radius_multiplier: float = 1.2
@export var zone_duration: float = 3.0
@export var tick_interval: float = 0.5
@export var zone_damage: float = 5.0

func _init():
	behavior_name = "Zone"
	description = "creates a continous AOE effect in an area"
	
func on_impact(spell, position):
	var final_radius = spell.area_radius * zone_radius_multiplier
	
	var zone = spell.spawn_zone(position, final_radius, zone_duration)
	
	zone.tick_interval = tick_interval
	zone.damage = zone_damage
