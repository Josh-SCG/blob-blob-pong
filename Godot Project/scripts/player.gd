extends CharacterBody2D

const GRAVITY =  30
const MAX_FALL_SPEED = 400
const ACCELERATION = 250
const JUMP_FORCE = 600

var is_jumping = false
var can_sword = true
var can_shield = true
var can_shoot = true

var max_health = 3
var health = 3

var max_bullets = 5
var bullets = 5

@onready var animation = $AnimationPlayer
@onready var heart_1 = get_node("../playerHealth/heart1")
@onready var heart_2 = get_node("../playerHealth/heart2")
@onready var heart_3 = get_node("../playerHealth/heart3")

@onready var bullet_1 = get_node("../bullets/bullet1")
@onready var bullet_2 = get_node("../bullets/bullet2")
@onready var bullet_3 = get_node("../bullets/bullet3")
@onready var bullet_4 = get_node("../bullets/bullet4")
@onready var bullet_5 = get_node("../bullets/bullet5")

@onready var swordUI = get_node("../abilities/sword")
@onready var swordUIText = get_node("../abilities/sword/swordTime")
@onready var shieldUI = get_node("../abilities/shield")
@onready var shieldUIText = get_node("../abilities/shield/shieldTime")

@export var swords : PackedScene = preload("res://sword.tscn")
@export var shield : PackedScene = preload("res://shield.tscn")
@export var bullet : PackedScene = preload("res://bullet.tscn")

var movementVector = Vector2.ZERO

func _ready():
	add_to_group("Player")
	swordUI.frame = 75
	swordUIText.visible = false
	shieldUI.frame = 59
	shieldUIText.visible = false
	
	heart_1.frame = 42
	heart_2.frame = 42
	heart_3.frame = 42
	
	bullet_1.frame = 82
	bullet_2.frame = 82
	bullet_3.frame = 82
	bullet_4.frame = 82
	bullet_5.frame = 82

func _physics_process(_delta):
	movement()
	#camera_zoom()
	attacks()
	swordUIText.text = str(snapped($SwordSkillTimer.time_left, 0.1))
	shieldUIText.text = str(snapped($ShieldTimer.time_left, 0.1))

func camera_zoom():
	if Input.is_action_just_pressed("scroll_in"):
		if $Camera2D.zoom < Vector2(2.32,2.32):
			$Camera2D.zoom += Vector2(0.33,0.33)
	if Input.is_action_just_pressed("scroll_out"):
		if $Camera2D.zoom > Vector2(1,1):
			$Camera2D.zoom -= Vector2(0.33,0.33)

func movement():
	velocity.y += GRAVITY #Always pushes player down
	velocity.x = (int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))) * ACCELERATION
	
	if velocity.y > MAX_FALL_SPEED: #Clamp the max fall speed
		velocity.y = MAX_FALL_SPEED
	
	if is_jumping && velocity.y >= 0:
		is_jumping = false
	
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x,0.0,0.2)
	
	if is_on_floor():
		if Input.is_action_just_pressed("up"):
			is_jumping = true
			velocity.y = -JUMP_FORCE
	
	move_and_slide()
	animSwitch()
	
func animSwitch():
	if velocity == Vector2(0,0):
		animation.play("idle")
	elif velocity.y <= 0 && !is_on_floor():
		animation.play("Falling")
	elif velocity.y > 0 && !is_on_floor():
		animation.play("Falling")
	elif velocity.x > 0 && is_on_floor():
		animation.play("move")
		$Sprite.scale.x = 1
	elif velocity.x < 0 && is_on_floor():
		animation.play("move")
		$Sprite.scale.x = -1
	else:
		animation.play("idle")

func attacks():
	if Input.is_action_just_pressed("sword") && can_sword:
		can_sword = false
		var swords_in_action = swords.instantiate()
		add_child(swords_in_action)
		swordUI.frame = 93
		$SwordSkillTimer.start()
		swordUIText.visible = true
		swordUIText.text = str($SwordSkillTimer.time_left)
	
	if Input.is_action_just_pressed("shield") && can_shield:
		can_shield = false
		var shield_in_action = shield.instantiate()
		add_child(shield_in_action)
		shieldUI.frame = 77
		$ShieldTimer.start()
		shieldUIText.visible = true
		shieldUIText.text = str($ShieldTimer.time_left)
	
	if Input.is_action_just_pressed("shoot") && bullets > 0:
		var bullet_in_action = bullet.instantiate()
		bullet_in_action.start(get_node("../PongBall"), (position + Vector2(0,-32)))
		get_parent().add_child(bullet_in_action)
		$ShootTimer.start()
		
		bullets -= 1
		if bullets == 0:
			bullet_1.frame = 81
			bullet_2.frame = 81
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 1:
			bullet_1.frame = 82
			bullet_2.frame = 81
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 2:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 3:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 4:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 82
			bullet_5.frame = 81

func hit_by_enemy():
	if health == 1:
		print("killshot")
		is_jumping = true
		velocity.y = -1.33*JUMP_FORCE
	elif health == 2:
		health -= 1
		is_jumping = true
		velocity.y = -1.33*JUMP_FORCE
		heart_1.frame = 42
		heart_2.frame = 41
		heart_3.frame = 41
	elif health == 3:
		health -= 1
		is_jumping = true
		velocity.y = -1.33*JUMP_FORCE
		heart_1.frame = 42
		heart_2.frame = 42
		heart_3.frame = 41
	#check for lives
	#if last life taken:
		#timer for x second
		#play death sound
		#lock control
		#change to results screen
	#else 
		#remove one life
		#bounce player up
	

func hit_by_ball():
	if health == 1:
		print("killshot")
	elif health == 2:
		health -= 1
		heart_1.frame = 42
		heart_2.frame = 41
		heart_3.frame = 41
	elif health == 3:
		health -= 1
		heart_1.frame = 42
		heart_2.frame = 42
		heart_3.frame = 41
	#check for lives
	#if last life taken:
		#timer for x second
		#play death sound
		#lock control
		#change to results screen
	#else remove one life

func heals():
	if health != max_health:
		health += 1
		if health == 2:
			heart_1.frame = 42
			heart_2.frame = 42
		elif health == 3:
			heart_1.frame = 42
			heart_2.frame = 42
			heart_3.frame = 42

func reload():
	if bullets < max_bullets:
		bullets += 1
		if bullets == 1:
			bullet_1.frame = 82
			bullet_2.frame = 81
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 2:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 3:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 4:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 82
			bullet_5.frame = 81
		elif bullets == 5:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 82
			bullet_5.frame = 82
		

func _on_sword_skill_timer_timeout():
	can_sword = true
	swordUI.frame = 75
	swordUIText.visible = false

func _on_shield_timer_timeout():
	can_shield = true
	shieldUI.frame = 59
	shieldUIText.visible = false

func _on_shoot_timer_timeout():
	if bullets < max_bullets:
		bullets += 1
		if bullets == 1:
			bullet_1.frame = 82
			bullet_2.frame = 81
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 2:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 81
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 3:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 81
			bullet_5.frame = 81
		elif bullets == 4:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 82
			bullet_5.frame = 81
		elif bullets == 5:
			bullet_1.frame = 82
			bullet_2.frame = 82
			bullet_3.frame = 82
			bullet_4.frame = 82
			bullet_5.frame = 82
