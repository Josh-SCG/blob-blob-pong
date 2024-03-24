extends CharacterBody2D

@onready var achieve = get_node("/root/AchievementTracking")

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
	healthBar.size.x -= 20
	kill()
	
func hit_by_sword():
	healthBar.size.x -= 5
	kill()

func kill():
	if healthBar.size.x <= 0:
		achieve.results_check_win = true
		get_tree().change_scene_to_file.bind("res://Menu Scenes/results.tscn").call_deferred()

func _on_character_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.hit_by_ball()
	elif body.is_in_group("Enemy"):
		body.kill("Pong")
