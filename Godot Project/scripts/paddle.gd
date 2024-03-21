extends Area2D


# Called when the node enters the scene tree for the first time.
var x = 3
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	position.y += x
	if position.y <= 8:
		x += 3
	elif position.y >= 340: #229 = 272 // 205 = 
		x -= 3
	
