extends RigidBody2D

var timer = 1
var is_processing = true

func _ready():
	randomize()
	timer = rand_range(0.2,2)

func _physics_process(delta):
	if is_processing:
		timer -= delta
		if timer <0:
			self.set_process(false)
			linear_velocity = Vector2()
			$CollisionShape2D.disabled = true
			sleeping                   = true
			is_processing              = false
#		print ("ok")

