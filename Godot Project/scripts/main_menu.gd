extends Node2D

func _on_play_pressed():
	get_tree().change_scene_to_file("res://level.tscn")

func _on_controls_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/controls.tscn")

func _on_achievements_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/achievements.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")

func _on_settings_pressed():
	pass # Replace with function body.

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/credits.tscn")

