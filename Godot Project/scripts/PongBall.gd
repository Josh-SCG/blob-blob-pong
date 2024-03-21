extends CharacterBody2D


const SPEED = 200
var direction = Vector2.ZERO

func _ready():
	direction.x = [1,-1].pick_random()
	direction.y = [1,-1].pick_random()

func _physics_process(_delta):

	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
