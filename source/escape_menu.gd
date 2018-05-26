extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var buttons = null
var current_button = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.buttons = [$TextureButton, $TextureButton2]

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_action_just_pressed("move_left_p1"):
		self.current_button = (self.current_button - 1) % 2
		self.buttons[self.current_button].grab_focus()
		
	if Input.is_action_just_pressed("move_right_p1"):
		self.current_button = (self.current_button + 1) % 2
		self.buttons[self.current_button].grab_focus()
	
	if Input.is_action_just_pressed("use_p1"):
		self.buttons[self.current_button]._pressed()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
