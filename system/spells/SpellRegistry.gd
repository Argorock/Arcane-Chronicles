extends Node
class_name SpellRegistry

@export var casting_types: Array = []
@export var elements: Array = []
@export var behaviors: Array = []


func _ready():
	casting_types = [
		load("res://system/spells/casting_types/arc.gd").new(),
		load("res://system/spells/casting_types/beam.gd").new(),
		load("res://system/spells/casting_types/bolt.gd").new(),
		load("res://system/spells/casting_types/burst_fire.gd").new(),
		load("res://system/spells/casting_types/cascade.gd").new(),
		load("res://system/spells/casting_types/cone.gd").new(),
		load("res://system/spells/casting_types/gattling_shot.gd").new(),
		load("res://system/spells/casting_types/mark.gd").new(),
		load("res://system/spells/casting_types/multi-shot.gd").new(),
		load("res://system/spells/casting_types/pulse.gd").new(),
		load("res://system/spells/casting_types/rain.gd").new(),
		load("res://system/spells/casting_types/self.gd").new(),
		load("res://system/spells/casting_types/shotgun.gd").new(),
		load("res://system/spells/casting_types/single_shot.gd").new(),
		load("res://system/spells/casting_types/snap.gd").new(),
		load("res://system/spells/casting_types/volley.gd").new(),
		load("res://system/spells/casting_types/wave.gd").new(),
	]

	elements = [
		load("res://system/spells/elements/acid.gd").new(),
		load("res://system/spells/elements/air.gd").new(),
		load("res://system/spells/elements/arcana.gd").new(),
		load("res://system/spells/elements/crystal.gd").new(),
		load("res://system/spells/elements/darkness.gd").new(),
		load("res://system/spells/elements/decay.gd").new(),
		load("res://system/spells/elements/earth.gd").new(),
		load("res://system/spells/elements/fire.gd").new(),
		load("res://system/spells/elements/ice.gd").new(),
		load("res://system/spells/elements/lava.gd").new(),
		load("res://system/spells/elements/life.gd").new(),
		load("res://system/spells/elements/light.gd").new(),
		load("res://system/spells/elements/lightning.gd").new(),
		load("res://system/spells/elements/metal.gd").new(),
		load("res://system/spells/elements/mud.gd").new(),
		load("res://system/spells/elements/poison.gd").new(),
		load("res://system/spells/elements/sand.gd").new(),
		load("res://system/spells/elements/smoke.gd").new(),
		load("res://system/spells/elements/star-fire.gd").new(),
		load("res://system/spells/elements/steam.gd").new(),
		load("res://system/spells/elements/toxin.gd").new(),
		load("res://system/spells/elements/void.gd").new(),
		load("res://system/spells/elements/water.gd").new(),
	]

	behaviors = [
		load("res://system/spells/behaviors/area-of-effect.gd").new(),
		load("res://system/spells/behaviors/bounce.gd").new(),
		load("res://system/spells/behaviors/burst_impact.gd").new(),
		load("res://system/spells/behaviors/converging.gd").new(),
		load("res://system/spells/behaviors/exploding.gd").new(),
		load("res://system/spells/behaviors/far_shot.gd").new(),
		load("res://system/spells/behaviors/growth.gd").new(),
		load("res://system/spells/behaviors/homing.gd").new(),
		load("res://system/spells/behaviors/orbiting.gd").new(),
		load("res://system/spells/behaviors/phasing.gd").new(),
		load("res://system/spells/behaviors/piercing.gd").new(),
		load("res://system/spells/behaviors/ricochet.gd").new(),
		load("res://system/spells/behaviors/shifting.gd").new(),
		load("res://system/spells/behaviors/splinter_shot.gd").new(),
		load("res://system/spells/behaviors/spread.gd").new(),
		load("res://system/spells/behaviors/zone.gd").new(),
	]


func get_casting_type_by_name(name: String) -> CastingTypeData:
	for ct in casting_types:
		if ct.type_name == name:
			return ct
	return null


func get_element_by_name(name: String) -> ElementData:
	for e in elements:
		if e.element_name == name:
			return e
	return null


func get_behavior_by_name(name: String) -> BehaviorData:
	for b in behaviors:
		if b.behavior_name == name:
			return b
	return null
