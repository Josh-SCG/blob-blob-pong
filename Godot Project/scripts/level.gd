extends Node2D

@onready var achieve = get_node("/root/AchievementTracking")
var score_l = 0
var score_r = 0

func _ready():
	achieve.heart_check = true

func _on_floor_body_entered(body):
	body.direction.y *= -1

func _on_top_body_entered(body):
	body.direction.y *= -1

func _on_wall_l_body_entered(body):
	body.direction.x = [1,-1].pick_random()
	body.direction.y = [1,-1].pick_random()
	body.position = Vector2(460,220)
	score_r += 1
	$"score-R".text = str(score_r)

func _on_wall_r_body_entered(body):
	body.direction.x = [1,-1].pick_random()
	body.direction.y = [1,-1].pick_random()
	body.position = Vector2(460,220)
	score_l += 1
	$"score-L".text = str(score_l)

func _on_left_paddle_body_entered(body):
	body.direction.x *= -1

func _on_right_paddle_body_entered(body):
	body.direction.x *= -1
