extends RigidBody2D

var timer = 1
var is_processing = true
var cleanup_time = 0

func _ready():
	randomize()
	timer = rand_range(0.2,0.5)
	cleanup_time = rand_range(10,15)

func _physics_process(delta):
	if is_processing:
		timer -= delta
		if timer <0:
			self.set_process(false)
			linear_velocity = Vector2()
			$CollisionShape2D.disabled = true
			sleeping                   = true
			is_processing              = false
	else:
		timer+=delta
		modulate = Color(1,1,1,1-(timer/cleanup_time))
		if timer>cleanup_time:
			queue_free()

