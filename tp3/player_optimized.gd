extends CharacterBody2D

class_name Player

enum State { STATE_JUMPING, STATE_IDLE, STATE_WALKING, STATE_FALLING, STATE_ATTACKING }

var current_state : State = State.STATE_IDLE

var UP = Vector2(0,-1)
const GRAVITY = 10
const MAXFALLSPEED = 200
const MAXSPEED = 200
const JUMPFORCE = 350

const ACCEL = 75.0

var vZero = Vector2()

var facing_right : bool = true
var attacking : bool = false

var motion = Vector2()

var dir

@onready var current_sprite : Sprite2D = $Sprite2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func fall():
	if is_on_floor():
		current_state = State.STATE_IDLE
		anim_player.play("idle")
func idle():
	if dir != 0:
		current_state = State.STATE_WALKING
		anim_player.play("walk")
		motion.x = ACCEL * dir  
	elif Input.is_action_just_pressed("ui_accept"):
		current_state = State.STATE_JUMPING
		motion.y = -JUMPFORCE
		anim_player.play("jump")
	elif not is_on_floor() and motion.y > 0:
		current_state = State.STATE_FALLING
		anim_player.play("fall")
	elif Input.is_action_just_pressed("attack"):
		current_state = State.STATE_ATTACKING
		anim_player.play("attack")
func jump():
	if motion.y >= 0:
		current_state = State.STATE_FALLING
		anim_player.play("fall")
	else:
		anim_player.play("jump")
func walk():
	motion.x = ACCEL * dir
	if dir > 0:
		facing_right = true
	elif dir < 0:
		facing_right = false
	else:
		current_state = State.STATE_IDLE
		motion = motion.lerp(Vector2.ZERO, 0.2)
		anim_player.play("idle")
		
	if not is_on_floor() and motion.y > 0:
		current_state = State.STATE_FALLING
		anim_player.play("fall")
	elif is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		current_state = State.STATE_JUMPING
		motion.y = -JUMPFORCE
		anim_player.play("jump")
	elif is_on_floor() and Input.is_action_just_pressed("attack"):
		current_state = State.STATE_ATTACKING
		anim_player.play("attack")
func attack():
	if !anim_player.is_playing():
		current_state = State.STATE_IDLE
		anim_player.play("idle")


func _physics_process(delta: float) -> void:
	dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	current_sprite.flip_h = !facing_right
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	match current_state:
		State.STATE_FALLING:
			fall()
		State.STATE_IDLE:
			idle()
		State.STATE_JUMPING:
			jump()
		State.STATE_WALKING:
			walk()
		State.STATE_ATTACKING:
			attack()
		_:
			anim_player.play("idle")
			
	if current_state == State.STATE_IDLE:
		motion.x = lerp(float(motion.x), 0.0, 0.1)  # Gradually stop the player
	else:
		motion.x = lerp(motion.x, float(dir * MAXSPEED), (ACCEL * delta) / MAXSPEED)  # Use input to control speed
	velocity = motion
	move_and_slide()
