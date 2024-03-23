extends CharacterBody2D

var speed = 7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	$Sprites.rotation += delta * speed
	
func _on_timer_timeout():
	queue_free()

func _on_sword_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill()
	elif body.is_in_group("Ball"):
		body.hit_by_sword()
