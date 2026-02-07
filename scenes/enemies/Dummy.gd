extends CharacterBody2D

@export var max_health := 999
var health := max_health

func take_damage(amount: int) -> void:
	health -= amount
	print("Damage dealt: ", amount, " | Dummy health: ", health)
	
	$AnimatedSprite2D.play("small_hit")
	await get_tree().create_timer(0.15).timeout
	$AnimatedSprite2D.play("idle")
	
	if health <= 0:
		reset_dummy()
		
func reset_dummy():
	print("Dummy reset")
	health = max_health
		


