extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# Const
const MOVE_SPEED  = 200 

export(int) var PLAYER_NUM

enum {STATE_WALK, STATE_IDLE, STATE_FIGHT, STATE_STABING}

var drag_item = null
var state = null
var stab_timer = 1
var samples_played = 0

var kill_count = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	self.state = STATE_IDLE
	
	# Color players
	if PLAYER_NUM == 1:
		$Sprite2.modulate = Color(1,0,0,1)
	if PLAYER_NUM == 2:
		$Sprite2.modulate = Color(0,1,0,1)
	if PLAYER_NUM == 3:
		$Sprite2.modulate = Color(0,0,1,1)
	
func _physics_process(delta):
	#
	# Move inputs
	#CanvasLayer/HSplitContainer/player1Label
	get_node("../../CanvasLayer/HBoxContainer/player"+str(PLAYER_NUM)+"Label").text = str(self.kill_count)
	
	var move = Vector2()
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://escape_menu.tscn")

	# Fight 
	if Input.is_action_pressed("alt_p" + str(PLAYER_NUM)):
		if self.drag_item == null:
			self.state = STATE_FIGHT
	else:

		var offset = MOVE_SPEED * delta
		var player_moved = false
		
		if Input.is_action_pressed("move_up_p" + str(PLAYER_NUM)) and position.y > 0:
			move.y  -= offset;
			player_moved = true
	
		if Input.is_action_pressed("move_down_p" + str(PLAYER_NUM)) and position.y < get_viewport_rect().size.y:
			move.y  += offset;
			player_moved = true
		
		if Input.is_action_pressed("move_left_p" + str(PLAYER_NUM)) and position.x > 0:
			move.x  -= offset;
			player_moved = true		
			$Sprite.flip_h = true
			$Sprite2.flip_h = true
	
		if Input.is_action_pressed("move_right_p" + str(PLAYER_NUM)) and position.x < get_viewport_rect().size.x:
			move.x  += offset;
			player_moved = true
			$Sprite.flip_h = false 
			$Sprite2.flip_h = false
	
		if player_moved and self.state != STATE_STABING:
			self.state = STATE_WALK
		elif self.state != STATE_STABING:
			self.state = STATE_IDLE
	
	#
	# Others
	#
	
	# Update animation
	match self.state:
		STATE_WALK:
			if $AnimationPlayer.current_animation != "walk":
				$AnimationPlayer.play("walk")
				$stepsAudioStreamPlayer2D.play()

		STATE_IDLE:
			if $AnimationPlayer.current_animation != "idle":
				$AnimationPlayer.play("idle")
				$stepsAudioStreamPlayer2D.stop()
#				move_and_slide(move * 100)
		STATE_FIGHT:
			for item in $"../items".get_children():
				if (
					item.state != item.STATE_DEAD 
					and item.state != item.STATE_DYING 
					and ( (item.position - position).length() < 20 ) 
					and ( item.dragged == false)
				):
					$draw.play()
					self.state = STATE_STABING
					item.state = item.STATE_DYING
					item.get_node("sacrificeAudioStreamPlayer2D").play()
					item.get_node("Sprite/AnimationPlayer").play("panic")
					self.kill_count += 1
					
					break
			
			if $AnimationPlayer.current_animation != "kill":
				$AnimationPlayer.play("kill")
				$stepsAudioStreamPlayer2D.stop()
#				move_and_slide(move * 100)
		STATE_STABING:
#			get_node("stab"+str(randi()%4+1)).play()
			$stepsAudioStreamPlayer2D.stop()
			stab_timer -= delta
			if stab_timer <= 0:
				stab_timer = 1
				self.state = STATE_IDLE
				samples_played = 0
			elif stab_timer <0.2 and samples_played == 2:
				samples_played += 1
				get_node("stab"+str(randi()%4+1)).play()
			elif stab_timer <0.5 and samples_played == 1 :
				samples_played +=1
				get_node("stab"+str(randi()%4+1)).play()
			elif stab_timer <0.8 and samples_played == 0 :
				samples_played +=1
				get_node("stab"+str(randi()%4+1)).play()
		

	move_and_slide(move * 100)

#			if $AnimationPlayer.current_animation != "kill":
#				$AnimationPlayer.play("kill")
	
	# Pick NPC
	if Input.is_action_just_pressed("use_p" + str(PLAYER_NUM)):
		if self.drag_item == null:
			# Hands empty - drag NPC			
			for item in $"../items".get_children():
				if item.state!=item.STATE_DEAD and ( (item.position - position).length() < 30 ) and ( item.dragged == false):
					item.drag(true)
					item.rotation = PI/2;
					
					self.drag_item = item
					$pickupAudioStreamPlayer2D.play()
					break
		else:
			# Hands occupied - left NPC
			self.drag_item.drag(false)
			self.drag_item.rotation = 0
			self.drag_item.position = self.position 
			self.drag_item = null
			
			get_node("dropAudioStreamPlayer2D").play()
			if position.x < $"../killzone".position.x +30 and position.x > $"../killzone".position.x -30 and position.y < $"../killzone".position.y +30 and position.y > $"../killzone".position.y -30:
				self.state = STATE_STABING
				$draw.play()
				$AnimationPlayer.play("kill")
				samples_played = 0
				self.kill_count += 3
				
	# Update position of picked NPC
	if self.drag_item != null:
		self.drag_item.position = self.position - Vector2(6, 12)
		
	