extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	pass

func _pressed():
	get_tree().quit()
	
func _on_mouse_entered():
	self.grab_focus()

func _on_mouse_exited():
	self.release_focus()