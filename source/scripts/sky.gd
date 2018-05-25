extends Node2D

var alpha = 0.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):

	rotation += delta;
	alpha = -sin(rotation)
	alpha = clamp(alpha * 2, 0, 1)
	$sky.modulate = Color(1,1,1, 1-alpha);
	
	pass
