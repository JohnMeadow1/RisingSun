extends Node2D

var npc_object = load("res://scenes/npc.tscn")
var timer = 0.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	timer += delta
	if timer > 1:
		timer = 0
		add_child(npc_object.instance())
	pass
