extends CharacterBody2D

@onready var sfxRef = get_node("/root/Sfx")
@export var knock: AudioStream


func _on_shield_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		sfxRef.sfxAudio(knock)
		body.knockback()
	elif body.is_in_group("Ball"):
		sfxRef.sfxAudio(knock)
		body.direction.y = -1
		body.direction.x *= -1


func _on_timer_timeout():
	queue_free()
