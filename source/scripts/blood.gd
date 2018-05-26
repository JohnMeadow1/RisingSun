extends RigidBody2D

var timer = 1

func _ready():
	randomize()
	timer = rand_range(0.2,2)

func _process(delta):
	timer -= delta
	if timer <0:
		set_process(false)
		linear_velocity = Vector2()
		$CollisionShape2D.disabled = true
		sleeping = true

