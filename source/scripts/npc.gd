extends Node2D

var  timer = 0.0
var  timer_change = 1

var speed = 0

var dir = Vector2()

var orient = 0

func _ready():
	
	randomize()
	
	position.x = rand_range(50,500)
	position.y = rand_range(50,500)
	
	speed = rand_range(0.3, 1.0)
	
	orient = rand_range(0,2*PI)
	
	dir = Vector2(sin(orient), cos(orient))

func _physics_process(delta):
	
	timer += delta * 2 * timer_change
	if timer > 1 or timer < -1:
		timer = clamp( timer, -1, 1 )
		timer_change = -timer_change
		dir = -dir
	
	position += dir * speed 
	
	if(dir.x > 0):
		$Sprite.flip_h = false 
	else:
		$Sprite.flip_h = true
	
	pass
