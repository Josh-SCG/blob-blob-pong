extends Node2D

@onready var achieve = get_node("/root/AchievementTracking")
@onready var shield = $achieveShield
@onready var sword = $achieveSword
@onready var heart = $achieveHeart
@onready var victory = $achieveVictory

# Called when the node enters the scene tree for the first time.
func _ready():
	shield.frame = 139 + int(achieve.shield)
	sword.frame = 155 + int(achieve.sword)
	heart.frame = 171 + int(achieve.heart)
	victory.frame = 187 + int(achieve.victory)


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")
