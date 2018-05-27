extends Node

var sun_set_timer       = 3.0
var points              = 0.0
var days                = 0.0
const POINTS_TO_HORIZON = 10.0



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func add_points(points):
	self.points += points
	if points>0:
		sun_set_timer = 3
	if self.points > self.days*40+20:
		self.points += 20
		self.days += 1
	
# Return value in range (0, 1) depending on current score
func get_sun_pos():
	return (self.points / POINTS_TO_HORIZON)
	
func get_num_of_days():
#	self.days = self.points / 40
#	print(self.days)
	return floor(self.days)

func _process(delta):
	sun_set_timer -= delta
	if sun_set_timer<0 and points>0:
		add_points(max(sun_set_timer*0.01,-0.01))
#		print (points)

