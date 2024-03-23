extends CharacterBody2D


const SPEED = 150
var direction = Vector2.ZERO
var possible_names = ["Robust Rhombus", "Resilient Rectangle", "Sturdy Square", "Tough Tetragon", "Bad Box", "Foul Four-sided Figure", "Trained Trapezoid", "Persistent Parallelogram"]
var displayed_name = "Pong - The "

@onready var healthBar = get_node("../Health Bar/bar")

func _ready():
	add_to_group("Ball")
	displayed_name += possible_names.pick_random()
	direction.x = [1,-1].pick_random()
	direction.y = [1,-1].pick_random()
	get_node("../Health Bar/Name").text = displayed_name

func _physics_process(_delta):
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()

func hit_by_bullet():
	healthBar.size.x -= 12.5
	
func hit_by_sword():
	healthBar.size.x -= 5

func _on_character_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.hit_by_ball()
	elif body.is_in_group("Enemy"):
		body.kill()
