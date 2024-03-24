extends CharacterBody2D

@onready var sfxRef = get_node("/root/Sfx")
@export var knock: AudioStream

var speed = 7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	$Sprites.rotation += delta * speed
	
func _on_timer_timeout():
	queue_free()

func _on_sword_area_2d_body_entered(body):
	if body.is_in_group("Enemy"):
		body.kill("Player")
		sfxRef.sfxAudio(knock)
	elif body.is_in_group("Ball"):
		body.hit_by_sword()
		sfxRef.sfxAudio(knock)
