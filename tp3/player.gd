extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var attacking : bool = false
var is_jumping : bool = false

@onready var _animation_player = $AnimationPlayer

func _physics_process(delta: float) -> void:
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		is_jumping = true
	else:
		is_jumping = false
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Handle attack.
	if Input.is_action_just_pressed("attack") and is_on_floor():
		print("attack")
		attacking = true
		_animation_player.play("attack")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0 and not attacking:
		velocity.x = direction * SPEED
		_animation_player.play("walk")
		if direction > 0:
			$Sprite2D.flip_h = false
		elif direction < 0:
			$Sprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Play animations based on state.
	if not attacking:
		if is_jumping:
			_animation_player.play("jump")
		elif velocity.x == 0 and is_on_floor():
			_animation_player.play("idle")

	move_and_slide()

	# Reset attack after the animation is done.
	if attacking and _animation_player.current_animation != "attack":
		attacking = false
