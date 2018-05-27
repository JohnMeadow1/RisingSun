extends Node2D

var npc_object     = load("res://scenes/npc.tscn")
var timer          = 0.0
var propagation    = 1.0
var is_propagating = false
var altar_position = Vector2()

const INITIAL_POPULATION = 300

func _ready():
	altar_position = $"../altar_position".position
	for i in range(INITIAL_POPULATION):
		add_child(npc_object.instance())
	pass

func _process(delta):
	timer += delta
	if timer > 1:
		timer = 0
		add_child(npc_object.instance())
	
	if is_propagating:
		propagation+=delta
		propagate_death()
		if propagation>=3:
			is_propagating = false
			propagation = 0.5
			
func propagate_death():
	for sacriface in get_children():
		if sacriface.state < 2 and (altar_position - sacriface.position).length() < 100.0*(propagation) :
			sacriface.pray(propagation)