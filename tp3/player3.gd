#extends CharacterBody2D
#
#
#var UP = Vector2(0,-1)
#const GRAVITY = 20
#const MAXFALLSPEED = 200
#const MAXSPEED = 100
#const JUMPFORCE = 300
#
#const ACCEL = 10.0
#
#var vZero = Vector2()
#
#var facing_right : bool = true
#
#var motion = Vector2()
#
#var current_sprite : Sprite2D
#var anim_player : AnimationPlayer
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#current_sprite = get_node("Sprite2D")
	#anim_player = get_node("AnimationPlayer")
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#
	#motion.y += GRAVITY
	#
	#if motion.y > MAXFALLSPEED:
		#motion.y = MAXFALLSPEED
	#
	#if facing_right:
		#current_sprite.flip_h = true
	#else:
		#current_sprite.flip_h = false
		#
	#if Input.is_action_pressed("ui_left"):
		#motion.x -= ACCEL
		#facing_right = false;
		#anim_player.play("walk")
	#elif Input.is_action_pressed("ui_right"):
		#motion.x += ACCEL
		#facing_right = true
		#anim_player.play("walk")
	#else:
		#motion = motion.lerp(Vector2.ZERO, 0.2)
		#anim_player.play("idle")
		#
	#if is_on_floor():
		#if Input.is_action_just_pressed('ui_accept'):
			#motion.y = -JUMPFORCE
	#
	#if !is_on_floor():
		#if motion.y < 0:
			#anim_player.play("jump")
		#elif motion.y > 0:
			#anim_player.play("fall")
	#
	#motion.x = lerp(motion.x, float(MAXSPEED * (1 if motion.x > 0 else -1)), ACCEL / MAXSPEED)
#
	#velocity = motion
	#move_and_slide()


extends CharacterBody2D

var UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 100
const JUMPFORCE = 300
const ACCEL = 10
var facing_right = true
var motion = Vector2()

var currentSprite : Sprite2D
var animPlayer : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	currentSprite = $Sprite2D
	animPlayer = $AnimationPlayer

func _physics_process(delta):
	motion.y += GRAVITY

	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED

	if facing_right:
		currentSprite.flip_h = false
	else:
		currentSprite.flip_h = true

	if Input.is_action_pressed("ui_left"):
		motion.x -= ACCEL
		facing_right = false
		animPlayer.play("Run")
	elif Input.is_action_pressed("ui_right"):
		motion.x += ACCEL
		facing_right = true
		animPlayer.play("Run")
	else:
		motion = Vector2.ZERO
		animPlayer.play("Idle")

	if is_on_floor():
		print("on floor")
		if Input.is_action_just_pressed("ui_jump"):
			motion.y = -JUMPFORCE
			print("motion.y = ", motion.y)

	if not is_on_floor():
		if motion.y < 0:
			animPlayer.play("jump")
		elif motion.y > 0:
			animPlayer.play("fall")

	motion.x = lerp(motion.x, float(MAXSPEED * (1 if motion.x > 0 else -1)) , ACCEL / MAXSPEED)

	velocity = motion
	move_and_slide()
