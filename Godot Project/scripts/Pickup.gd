extends Area2D

var min_size = 0.8
var max_size = 1.1

var can_shrink = true
var rate = 0.0075

var type = "null"

func start(_type):
	type = _type

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_shrink:
		shrink(rate)
		if $Sprite.scale.x < min_size:
			can_shrink = false
	if !can_shrink:
		grow(rate)
		if $Sprite.scale.x > max_size:
			can_shrink = true

func shrink(amount):
	$Sprite.scale.x -= amount
	$Sprite.scale.y -= amount
	
func grow(amount):
	$Sprite.scale.x += amount
	$Sprite.scale.y += amount

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if type == "health":
			body.heals()
		elif type == "bullet":
			body.reload()
		queue_free()


func _on_timer_timeout():
	queue_free()
