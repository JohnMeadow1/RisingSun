extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Const
const MOVE_SPEED  = 200 

export(int) var PLAYER_NUM

var drag_item = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	# Color players
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
	var offset = MOVE_SPEED * delta
	var is_moving = false
	
	if Input.is_action_pressed("move_up_p" + str(PLAYER_NUM)) and position.y > 0:
		move.y  -= offset;
		is_moving = true

	if Input.is_action_pressed("move_down_p" + str(PLAYER_NUM)) and position.y < get_viewport_rect().size.y:
		move.y  += offset;
		is_moving = true

	if Input.is_action_pressed("move_left_p" + str(PLAYER_NUM)) and position.x > 0:
		move.x  -= offset;
		is_moving = true
		$Sprite.flip_h = true

	if Input.is_action_pressed("move_right_p" + str(PLAYER_NUM)) and position.x < get_viewport_rect().size.x:
		move.x  += offset;
		is_moving = true
		$Sprite.flip_h = false 
	
	move_and_slide(move * 100)

	#
	# Others
	#
	
	# Update animation
	if is_moving:
		if $AnimationPlayer.current_animation != "walk":
			$AnimationPlayer.play("walk")
	else:
		$AnimationPlayer.play("idle")
	
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
		
	