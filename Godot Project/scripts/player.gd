extends CharacterBody2D

const GRAVITY =  30
const MAX_FALL_SPEED = 400
const ACCELERATION = 250
const JUMP_FORCE = 600


var is_jumping = false
@onready var animation = $AnimationPlayer

var movementVector = Vector2.ZERO

func _physics_process(_delta):
	movement()
	camera_zoom()

func camera_zoom():
	if Input.is_action_just_pressed("scroll_in"):
		if $Camera2D.zoom < Vector2(2.32,2.32):
			$Camera2D.zoom += Vector2(0.33,0.33)
	if Input.is_action_just_pressed("scroll_out"):
		if $Camera2D.zoom > Vector2(1,1):
			$Camera2D.zoom -= Vector2(0.33,0.33)


func movement():
	velocity.y += GRAVITY #Always pushes player down
	velocity.x = (int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))) * ACCELERATION
	
	if velocity.y > MAX_FALL_SPEED: #Clamp the max fall speed
		velocity.y = MAX_FALL_SPEED
	
	if is_jumping && velocity.y >= 0:
		is_jumping = false
	
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x,0.0,0.2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("up"):
			is_jumping = true
			velocity.y = -JUMP_FORCE
	
	move_and_slide()
	animSwitch()
	
func animSwitch():
	if velocity == Vector2(0,0):
		animation.play("idle")
	elif velocity.y <= 0 && !is_on_floor():
		animation.play("Falling")
	elif velocity.y > 0 && !is_on_floor():
		animation.play("Falling")
	elif velocity.x > 0 && is_on_floor():
		animation.play("move")
		$Sprite.scale.x = 1
	elif velocity.x < 0 && is_on_floor():
		animation.play("move")
		$Sprite.scale.x = -1
	else:
		animation.play("idle")

