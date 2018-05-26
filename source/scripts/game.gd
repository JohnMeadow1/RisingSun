extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var points = 0
var days = 0 
const POINTS_TO_HORIZON = 10.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func add_points(points):
	self.points += points
	
# Return value in range (0, 1) depending on current score
func get_sun_pos():
	print(self.points / POINTS_TO_HORIZON)
	return (self.points / POINTS_TO_HORIZON)
	
func get_num_of_days():
	self.days = fmod(self.points, 4.0)
	print(self.days)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
