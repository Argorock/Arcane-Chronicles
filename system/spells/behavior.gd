extends Resource
class_name BehaviorData

@export var behavior_name: String = "Unnamed Behavior"
@export var description: String = ""

# -------------------------
# NUMERIC MODIFIERS
# -------------------------
@export var damage_multiplier: float = 1.0
@export var radius_multiplier: float = 1.0
@export var duration_multiplier: float = 1.0
@export var speed_multiplier: float = 1.0

# -------------------------
# FLAGS (runtime capabilities)
# -------------------------
@export var can_pierce: bool = false
@export var can_ricochet: bool = false
@export var can_home: bool = false
@export var can_split: bool = false
@export var can_explode: bool = false

# -------------------------
# APPLY STAT MODIFIERS
# -------------------------
func apply_modifiers(stats: Dictionary) -> void:
	stats.damage *= damage_multiplier
	stats.radius *= radius_multiplier
	stats.duration *= duration_multiplier
	stats.speed *= speed_multiplier

# -------------------------
# EVENT HOOKS
# -------------------------
func on_spawn(projectile): pass
func on_tick(projectile, delta): pass
func on_hit(projectile, target): pass
func on_impact(projectile, position): pass
func on_expire(projectile): pass
func on_trigger(projectile): pass

# -------------------------
# SPECIAL RULES (optional)
# -------------------------
func apply_special_rules(projectile, trigger_data): pass
