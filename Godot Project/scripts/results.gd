extends Node2D

@onready var achieve = get_node("/root/AchievementTracking")
@onready var audioRef = get_node("/root/AudioManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	$victory/minionNum.text = str(achieve.number_of_minions)
	$victory/bulletNum.text = str(achieve.number_of_shots)
	$victory/swordNum.text = str(achieve.number_of_swords)
	$victory/shieldNum.text = str(achieve.number_of_shields)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if achieve.results_check_win:
		$victory.visible = true
		$died.visible = false
		achieve.victory = 1
		if achieve.heart_check:
			achieve.heart = 1
	else:
		$victory.visible = false
		$died.visible = true
	if achieve.shield_track >= 20:
		achieve.shield = 1
	if achieve.sword_track >= 20:
		achieve.sword = 1

func _on_menu_pressed():
	achieve.number_of_minions = 0
	achieve.number_of_shots = 0
	achieve.number_of_swords = 0
	achieve.number_of_shields = 0
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")
	audioRef.play_menu_song()
