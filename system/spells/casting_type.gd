extends Resource
class_name CastingTypeData

@export var type_name: String = "Unnamed"
@export var description: String = ""
@export var icon: Texture2D = null

#		modifiers for the casting type
@export var cast_time_multiplier: float = 1.0
@export var cooldown_multiplier: float = 1.0
@export var speed_multiplier: float = 1.0
@export var range_multiplier: float = 1.0
@export var mana_cost_multiplier: float = 1.0

#		identity Origin

enum Origin {
	CASTER,
	SKY,
	TARGET
}

@export var origin: Origin = Origin.CASTER

# 		identity Shape

enum Shape {
	PROJECTILE,
	LINE,
	CONE,
	WALL,
	AREA,
	ARC,
	NONE
}

@export var shape: Shape = Shape.PROJECTILE


#		identity Movement

enum Motion {
	STATIC,
	TRAVEL_FORWARD,
	FALLING,
	SWEEPING,
	SEQUENTIAL
}

@export var motion: Motion = Motion.STATIC

#		identity Time

enum Persistence {
	INSTANT,
	BURST,
	CONTINUOUS,
	SEQUENTIAL
}

@export var persistence: Persistence = Persistence.INSTANT

#		projectile parameters

@export var projectile_count: int = 1
@export var spread_angle: float = 0.0
@export var arc_height: float = 0.0

func apply_special_rules(spell):
	pass
