extends Node2D

var alpha = 0.0

var night_color = Color (0.22, 0.25, 0.8)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):

	rotation += delta;
	$sun.rotation -= delta;
	
	alpha = -sin(rotation)
	alpha = clamp(alpha * 2, 0, 1)
#	$"../../sky".modulate = Color(1,1,1, 1-alpha)
	$nightsky.modulate=Color( 1, 1, 1, 1-alpha )
	var local_color = Color( 0.22*(1-alpha) +alpha, 0.25*(1-alpha) +alpha, 0.8*(1-alpha) +alpha, 1 )
	$"../../foreground".modulate = local_color
	$"../background".modulate   = local_color
	$"../temple".modulate       = local_color
	$"../clouds".modulate       = local_color
	$"../clouds2".modulate      = local_color
	pass
