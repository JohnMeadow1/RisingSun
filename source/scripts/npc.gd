extends Node2D

var walk_timer = null
var idle_timer = null

enum {STATE_IDLE, STATE_WALKING}

var speed = 0
var dir = Vector2()
var dragged = false
var state = STATE_IDLE

func _ready():
	randomize()
	
	# Move AI
	self.walk_timer = Timer.new()
	self.walk_timer.set_one_shot(true)
	self.add_child(self.walk_timer)
	
	self.idle_timer = Timer.new()
	self.idle_timer.set_one_shot(true)
	self.add_child(self.idle_timer)
	
	position.x = rand_range(50,500)
	position.y = rand_range(50,500)
	
	# Init behavior
	if randi() % 2:
		self.randomize_move()
	else:
		self.randomize_idle()
	
func randomize_move():
	$Sprite/AnimationPlayer.play("walk")
	self.state = STATE_WALKING

	# Timer
	self.walk_timer.wait_time = rand_range(3.0, 5.0)
	self.walk_timer.start()
	
	speed = rand_range(0.3, 1.0)
	var orient = rand_range(0, 2 * PI)
	dir = Vector2(sin(orient), cos(orient))

func randomize_idle():
	$Sprite/AnimationPlayer.play("idle")
	self.state = STATE_IDLE
	
	# Timer	
	self.idle_timer.wait_time = rand_range(1.0, 3.0)
	self.idle_timer.start()
	
func drag(flag):
	self.dragged = flag
	
	if flag:
		$Sprite/AnimationPlayer.play("panic")
	else:
		randomize_move()

func _physics_process(delta):
	if self.dragged:
		return
	
	match self.state:
		#######################################################
		STATE_IDLE:
			# Stopped
			if self.idle_timer.is_stopped():
				self.randomize_move()
			
		#######################################################
		STATE_WALKING:
			# Walking
			if self.walk_timer.is_stopped():
				self.randomize_idle()
			else:
				if !get_viewport_rect().has_point(self.position):
					dir = -dir
				
				position += dir * speed
				
				if(dir.x > 0):
					$Sprite.flip_h = false 
				else:
					$Sprite.flip_h = true