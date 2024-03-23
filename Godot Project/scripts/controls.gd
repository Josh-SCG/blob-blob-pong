extends Node2D


@onready var movement = $movement
@onready var sword = $sword
@onready var shield = $shield
@onready var shoot = $shoot
@onready var pause = $pause
@onready var control_name = $controlInfoBox/controlName
@onready var control_info = $controlInfoBox/controlInfo
@onready var page_count = $controlInfoBox/pageNum

var current_page = 1

func _ready():
	$up.visible = false
	control_name.text = "What is the goal?"
	control_info.text = "Defeat the square menace knwon as Pong. Make use of your various abilities to deal damage and regain resources."
	page_count.text = "1/6"
	movement.visible = false
	sword.visible = false
	shield.visible = false
	shoot.visible = false
	pause.visible = false

func change_content():
	if current_page == 1:
		control_name.text = "What is the goal?"
		control_info.text = "Defeat the square menace knwon as Pong. Make use of your various abilities to deal damage and regain resources."
		movement.visible = false
		sword.visible = false
		shield.visible = false
		shoot.visible = false
		pause.visible = false
		page_count.text = "1/6"
	elif current_page == 2:
		control_name.text = "Movement"
		control_info.text = "You can move around the screen with the controls. You can also use being damaged by smaller enemies to be bounced up at cost to your health."
		movement.visible = true
		sword.visible = false
		shield.visible = false
		shoot.visible = false
		pause.visible = false
		page_count.text = "2/6"
	elif current_page == 3:
		control_name.text = "Sword Attacks"
		control_info.text = "You can damage enemies with your aura of swords. This will immediately kill smaller enemies and slightly hurt Pong."
		movement.visible = false
		sword.visible = true
		shield.visible = false
		shoot.visible = false
		pause.visible = false
		page_count.text = "3/6"
	elif current_page == 4:
		control_name.text = "Shield"
		control_info.text = "Using your shield, you can bounce all enemies away, smaller ones will drop bullets if you do and Pong will be repelled. Smaller enemies can only be repelled once."
		movement.visible = false
		sword.visible = false
		shield.visible = true
		shoot.visible = false
		pause.visible = false
		page_count.text = "4/6"
	elif current_page == 5:
		control_name.text = "Shooting"
		control_info.text = "You can shoot homing projectiles at Pong. Be cautious as you have a limited amount that will refresh over time, you can also pick up from smaller enemies. These deal great damage to Pong but disappear after a time."
		movement.visible = false
		sword.visible = false
		shield.visible = false
		shoot.visible = true
		pause.visible = false
		page_count.text = "5/6"
	elif current_page == 6:
		control_name.text = "Pause"
		control_info.text = "You can pause the game at any point to return to the menu or to take a break."
		movement.visible = false
		sword.visible = false
		shield.visible = false
		shoot.visible = false
		pause.visible = true
		page_count.text = "6/6"

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu Scenes/main_menu.tscn")


func _on_up_pressed():
	if current_page != 1:
		current_page -= 1
		change_content()
		$down.visible = true
		if current_page == 1:
			$up.visible = false


func _on_down_pressed():
	if current_page != 6:
		current_page += 1
		change_content()
		$up.visible = true
		if current_page == 6:
			$down.visible = false
