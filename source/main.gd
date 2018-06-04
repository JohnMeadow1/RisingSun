extends Node

var  timer = 0.0
var  timer_change = 1

func _ready():
	$bg_music.play()
	$bg_music.autoplay = true

func _process(delta):
#	timer += delta *2 * timer_change
#	if timer > 1 or timer < -1:
#		timer = clamp( timer, -1, 1 )
#		timer_change = -timer_change
#
#	$Sprite.position.x += timer
	pass
