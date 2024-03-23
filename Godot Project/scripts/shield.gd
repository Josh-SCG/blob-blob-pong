extends CharacterBody2D

func _on_shield_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.knockback()
	elif body.is_in_group("Ball"):
		body.direction.y = -1
		body.direction.x *= -1


func _on_timer_timeout():
	queue_free()
