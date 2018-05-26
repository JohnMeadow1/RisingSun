extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var points = 0
const POINTS_TO_HORIZON = 10.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func add_points(points):
	self.points += points
	
# Return value in range (0, 1) depending on current score
func get_sun_pos():
	return (self.points / POINTS_TO_HORIZON)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
