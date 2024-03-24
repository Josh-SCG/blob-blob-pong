extends Node2D

@onready var audioRef = get_node("/root/AudioManager")

func _on_play_pressed():
	audioRef.play_fight_song()
	get_tree().change_scene_to_file("res://level.tscn")

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/controls.tscn")

func _on_achievements_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/achievements.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/settings.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/credits.tscn")

