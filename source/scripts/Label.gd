extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var day = game.get_num_of_days()
	if day <= 0 :
		text = "Day 0"
	else:
		text = "Day " + str(day);
	pass
