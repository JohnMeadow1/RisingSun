extends Node2D

var alpha = 0.0

var night_color = Color (0.22, 0.25, 0.8)
var sun_pos = 0

const SUN_SPEED = 0.1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.sun_pos = $sun.position

func _process(delta):
	
	if rotation < game.get_sun_pos() * (PI/2):
		rotation += delta * SUN_SPEED;
		rotation = min(rotation, game.get_sun_pos() * (PI/2))
		$sun.frame=0
	elif rotation >= game.get_sun_pos() * (PI/2):
		rotation -= delta * SUN_SPEED;
		rotation = max(rotation, game.get_sun_pos() * (PI/2))
		$sun.frame=1
	$sun.rotation = -rotation
	
	# Modify sun trajectory
	var sun_mod = -clamp(cos(rotation + (PI/2)), -1, 0)
	var sun_tmp_pos = self.sun_pos
	sun_tmp_pos.x = -170 + sun_mod * 50
	$sun.position = sun_tmp_pos
	
	alpha = -sin(rotation + PI)
	alpha = clamp(alpha * 2, 0, 1)
	$nightsky.modulate=Color( 1, 1, 1, 1-alpha )
	var local_color = Color( 0.22*(1-alpha) +alpha, 0.25*(1-alpha) +alpha, 0.8*(1-alpha) +alpha, 1 )

	$"../../foreground".modulate = local_color
#	$"../../foreground/items".modulate = local_color
	$"../Node2D".modulate       = local_color
	$"../blood_pool".modulate   = local_color
#	$"../temple".modulate       = local_color
#	$"../clouds".modulate       = local_color
#	$"../clouds2".modulate      = local_color
	pass
