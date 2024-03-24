extends CanvasLayer

@onready var audioRef = get_node("/root/AudioManager")
@onready var achieve = get_node("/root/AchievementTracking")

func _on_play_button_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.queue_free()


func _on_menu_button_pressed():
	get_tree().paused = false
	achieve.number_of_minions = 0
	achieve.number_of_shots = 0
	achieve.number_of_swords = 0
	achieve.number_of_shields = 0
	audioRef.play_menu_song()
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")
