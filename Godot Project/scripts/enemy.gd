extends CharacterBody2D

@export var speed = 2
var dir = "null"
var can_be_knocked = true

@onready var achieve = get_node("/root/AchievementTracking")

@export var healthPickup : PackedScene = preload("res://health_pickup.tscn")
@export var bulletPickup : PackedScene = preload("res://bullet_pickup.tscn")

func _ready():
	add_to_group("Enemy")
	$Exclaim.visible = false
	if self.global_position.x > 450:
		dir = "right"
		speed *= 1
		$AnimatedSprite2D.flip_h = true
	elif self.global_position.x < 450:
		dir = "left"
		speed *= -1
		$AnimatedSprite2D.flip_h = false
	

func knockback():
	achieve.shield_track += 1
	if dir == "left" && can_be_knocked:
		can_be_knocked = false
		$Exclaim.visible = true
		dir = "right"
		speed *= -1
		$AnimatedSprite2D.flip_h = true
		$bulletTimer.start()
	elif dir == "right" && can_be_knocked:
		can_be_knocked = false
		$Exclaim.visible = true
		dir = "left"
		speed *= -1
		$AnimatedSprite2D.flip_h = false
		$bulletTimer.start()
	

func _physics_process(_delta):
	move()

func move():
	position.x -= speed

func _on_timer_timeout():
	self.queue_free()

func kill(source):
	if source == "Player":
		achieve.sword_track += 1
		achieve.heart_check = false
		achieve.number_of_minions += 1
	speed = 0
	$CollisionShape2D.set_deferred("disabled", true)
	$enemyCollider/CollisionShape2D.set_deferred("disabled", true)
	$deathTimer.start()
	

func _on_enemy_collider_body_entered(body):
	if body.is_in_group("Player"):
		body.hit_by_enemy()


func _on_death_timer_timeout():
	var health = healthPickup.instantiate()
	health.start("health")
	health.global_position = global_position
	get_tree().get_root().add_child(health)
	queue_free()


func _on_bullet_timer_timeout():
	var bullet = bulletPickup.instantiate()
	bullet.start("bullet")
	bullet.global_position = global_position
	get_tree().get_root().add_child(bullet)
