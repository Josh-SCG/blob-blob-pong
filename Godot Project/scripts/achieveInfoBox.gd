extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$achieveName.text = "Here be achievements"
	$achieveInfo.text = "Hover over an achievement icon to learn how to unlock it!"

func _on_shield_achive_box_mouse_entered():
	$achieveName.text = "Shielded"
	$achieveInfo.text = "Repelled many an enemy with your shields."

func _on_shield_achive_box_mouse_exited():
	$achieveName.text = "Here be achievements"
	$achieveInfo.text = "Hover over an achievement icon to learn how to unlock it!"

func _on_sword_achive_box_mouse_entered():
	$achieveName.text = "Veteran Slayer"
	$achieveInfo.text = "Slashed many an enemy with your blades."

func _on_sword_achive_box_mouse_exited():
	$achieveName.text = "Here be achievements"
	$achieveInfo.text = "Hover over an achievement icon to learn how to unlock it!"

func _on_heart_achive_box_mouse_entered():
	$achieveName.text = "A Loving Heart"
	$achieveInfo.text = "Took the time to not harm any of the minions of Pong."

func _on_heart_achive_box_mouse_exited():
	$achieveName.text = "Here be achievements"
	$achieveInfo.text = "Hover over an achievement icon to learn how to unlock it!"

func _on_victory_achive_box_mouse_entered():
	$achieveName.text = "A well-rounded Hero"
	$achieveInfo.text = "Rid the world of Pong."

func _on_victory_achive_box_mouse_exited():
	$achieveName.text = "Here be achievements"
	$achieveInfo.text = "Hover over an achievement icon to learn how to unlock it!"
