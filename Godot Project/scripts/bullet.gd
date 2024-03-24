extends CharacterBody2D

@onready var sfxRef = get_node("/root/Sfx")
@export var hit: AudioStream

var speed = 200
var turn_force = 200

var acceleration = Vector2.ZERO

var target = null

func start(_target, _position):
	position = _position
	rotation += randf_range(-0.09, 0.09)
	velocity = transform.y * speed * -1
	target = _target

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * turn_force
	return steer
	

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle()
	position += velocity * delta

func _on_timer_timeout():
	queue_free()

func _on_bullet_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		sfxRef.sfxAudio(hit)
		body.hit_by_bullet()
		queue_free()
