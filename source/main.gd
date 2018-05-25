extends Node

var  timer = 0.0
var  timer_change = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	timer += delta *2 * timer_change
	if timer > 1 or timer < -1:
		timer = clamp( timer, -1, 1 )
		timer_change = -timer_change
		
	$Sprite.position.x += timer
