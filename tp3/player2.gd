#extends CharacterBody2D
#
#
#const SPEED = 150.0
#const JUMP_VELOCITY = -400.0
#
#@onready var _animation_player = $AnimationPlayer
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#_animation_player.play("walk")
		#velocity.x = direction * SPEED
		#if direction > 0:
			#$Sprite2D.flip_h = false
		#elif direction < 0:
			#$Sprite2D.flip_h = true
	#else:
		#_animation_player.stop()
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
