extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _pressed():
	get_tree().change_scene("res://main.tscn")
	
func _on_mouse_entered():
	self.grab_focus()

func _on_mouse_exited():
	self.release_focus()