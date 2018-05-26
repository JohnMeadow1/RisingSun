extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Const
const MOVE_SPEED  = 200 

const BOOST_TIME  = 0.4
const BOOST_SPEED = 200

export(int) var PLAYER_NUM

var boost_timer = null
var drag_item = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	# Setup timer for boost  
	self.boost_timer = Timer.new()
	self.boost_timer.wait_time = BOOST_TIME
	self.boost_timer.set_one_shot(true)
	self.add_child(self.boost_timer)
	if PLAYER_NUM == 1:
		$Sprite2.modulate = Color(1,0,0,1)
	if PLAYER_NUM == 2:
		$Sprite2.modulate = Color(0,1,0,1)
	if PLAYER_NUM == 3:
		$Sprite2.modulate = Color(0,0,1,1)
	
func _process(delta):
		
	#
	# Move inputs
	#
	var move = Vector2()
#	var offset = (MOVE_SPEED + (self.boost_timer.time_left / self.boost_timer.wait_time) * BOOST_SPEED) * delta
	var offset = MOVE_SPEED *delta
	
	if Input.is_action_pressed("move_up_p" + str(PLAYER_NUM)) and position.y > 0:
#		position.y -= offset;
		move.y  -= offset;

	if Input.is_action_pressed("move_down_p" + str(PLAYER_NUM)) and position.y < get_viewport_rect().size.y:
#		position.y += offset;
		move.y  += offset;

	if Input.is_action_pressed("move_left_p" + str(PLAYER_NUM)) and position.x > 0:
#		position.x -= offset;
		move.x  -= offset;

	if Input.is_action_pressed("move_right_p" + str(PLAYER_NUM)) and position.x < get_viewport_rect().size.x:
#		position.x += offset;
		move.x  += offset;

	# Boost
	if Input.is_action_pressed("alt_p" + str(PLAYER_NUM)) and position.x < get_viewport_rect().size.x:
		self.boost_timer.start()
		
	
	move_and_slide(move *100)
	#
	# Others
	#
	
	# Pick item on the floor
	if Input.is_action_just_pressed("use_p" + str(PLAYER_NUM)):
		if self.drag_item == null:
			# Hands empty - drag item			
			for item in $"../items".get_children():
				if ( (item.position - position).length() < 30 ) and ( item.dragged == false):
					item.drag(true)
					item.rotation = PI/2;
					
					self.drag_item = item
					get_node("pickupAudioStreamPlayer2D").play()
					break
		else:
			# Hands occupied - left item
			self.drag_item.drag(false)
			self.drag_item.rotation = 0
			
			self.drag_item = null
			get_node("dropAudioStreamPlayer2D").play()
				
	# Update position of picked item
	if self.drag_item != null:
		self.drag_item.position = self.position
		
	