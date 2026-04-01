extends Resource
class_name CastingTypeData

var stats := {
	"damage_multiplier": 1.0,
	"speed_multiplier": 1.0,
	"range_multiplier": 1.0,
	"mana_cost_multiplier": 1.0,
	"cast_time_multiplier": 1.0
}

# -------------------------
# ENUMS
# -------------------------

enum Pattern {
	SINGLE,
	MULTI,
	BURST,
	SHOTGUN,
	BEAM,
	CONE,
	WAVE,
	PULSE,
	GATLING,
	RAIN,
	MARK,
	CASCADE,
	SELF,
	SNAP,
	VOLLEY,
}

enum Origin {
	CASTER,
	TARGET,
	SKY,
}

enum Shape {
	PROJECTILE,
	LINE,
	CONE,
	WALL,
	AREA,
	ARC,
	NONE,
}

enum Motion {
	STATIC,
	TRAVEL_FORWARD,
	FALLING,
	SWEEPING,
	SEQUENTIAL,
}

enum Persistence {
	INSTANT,
	BURST,
	CONTINUOUS,
	SEQUENTIAL,
}

# -------------------------
# BASIC INFO
# -------------------------

@export var type_name: String = "Unnamed Casting Type"
@export var description: String = ""

@export var pattern: Pattern = Pattern.SINGLE

# -------------------------
# CORE MULTIPLIERS
# -------------------------

@export var cast_time_multiplier: float = 1.0
@export var cooldown_multiplier: float = 1.0
@export var speed_multiplier: float = 1.0
@export var range_multiplier: float = 1.0
@export var mana_cost_multiplier: float = 1.0
@export var projectile_scale: float = 1.0

# -------------------------
# IDENTITY FIELDS
# -------------------------

@export var origin: Origin = Origin.CASTER
@export var shape: Shape = Shape.PROJECTILE
@export var motion: Motion = Motion.TRAVEL_FORWARD
@export var persistence: Persistence = Persistence.INSTANT


# -------------------------
# PROJECTILE / ARC / SPREAD
# -------------------------

@export var projectile_count: int = 1
@export var spread_degrees: float = 0.0
@export var arc_height: float = 0.0

# -------------------------
# BEHAVIOR FLAGS
# -------------------------

@export var uses_projectile: bool = true
@export var uses_beam: bool = false
@export var uses_instant_hit: bool = false
@export var uses_cone: bool = false

# NEW FLAG

@export var gravity_enabled: bool = false
@export var homing_enabled: bool = false
@export var undodgeable: bool = false

# -------------------------
# SCENE REFERENCES
# -------------------------

# NEW: Cone scene reference
var cone_scene: PackedScene
# (Later we’ll add wave_scene, pulse_scene, etc., but not yet.)

# -------------------------
# TIMING / FEEL
# -------------------------

@export var fire_rate_multiplier: float = 1.0
@export var duration: float = 0.0



func apply_pattern_flags() -> void:
	uses_projectile = false
	uses_beam = false
	uses_instant_hit = false
	uses_cone = false

	match pattern:
		Pattern.BEAM:
			uses_beam = true

		Pattern.CONE:
			uses_cone = true

		Pattern.WAVE:
			uses_projectile = true

		Pattern.PULSE:
				uses_projectile = true

		Pattern.SNAP:
			uses_instant_hit = true

		Pattern.GATLING:
			uses_projectile = true

		Pattern.VOLLEY, Pattern.RAIN, Pattern.CASCADE, Pattern.SINGLE, Pattern.MULTI, Pattern.BURST, Pattern.SHOTGUN:
			uses_projectile = true

		Pattern.SELF:
			uses_instant_hit = true

		_:
			uses_projectile = true

