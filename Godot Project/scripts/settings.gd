extends Node2D

var master_bus = AudioServer.get_bus_index("Master")
var sfx_bus = AudioServer.get_bus_index("sfx")
var music_bus = AudioServer.get_bus_index("music")

@export var sound: AudioStream
@onready var audioRef = get_node("/root/AudioManager")
@onready var sfxRef = get_node("/root/Sfx")

func _ready():
	$music_slider.value = AudioServer.get_bus_volume_db(music_bus)
	$sfx_slider.value = AudioServer.get_bus_volume_db(sfx_bus)

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(music_bus, true)
	else:
		AudioServer.set_bus_mute(music_bus, false)


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, value)
	
	if value == -30:
		AudioServer.set_bus_mute(sfx_bus, true)
	else:
		AudioServer.set_bus_mute(sfx_bus, false)


func _on_test_sfx_pressed():
	sfxRef.sfxAudio(sound)
