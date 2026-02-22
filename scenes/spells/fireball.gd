extends Area2D

@export var speed := 400
@export var damage := 20
var direction := Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta):
	position += direction * speed * delta
	
func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()
	queue_free()
