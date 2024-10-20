extends CharacterBody2D

#class_name 

var UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 100
const JUMPFORCE = 300

const ACCEL = 10.0

var vZero = Vector2()

var facing_right : bool = true
var attacking : bool = false

var motion = Vector2()

@onready var current_sprite : Sprite2D = $Sprite2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Ou l'équivalent dans votre code
	
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	current_sprite.flip_h = !facing_right
	
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	
	if not attacking:
		if dir != 0 and not attacking:
			motion.x = lerp(motion.x, dir * MAXSPEED, ACCEL * delta)  # Accelerate based on input
			#motion.x += ACCEL * dir
			anim_player.play("walk")
			if dir > 0:
				facing_right = true
			elif dir < 0:
				facing_right = false
		else:
			motion = motion.lerp(Vector2.ZERO, 0.2)
			anim_player.play("idle")
	
	if is_on_floor() and Input.is_action_just_pressed('ui_accept'):
		motion.y = -JUMPFORCE
		
	if is_on_floor() and Input.is_action_just_pressed('attack'):
		attacking = true
		anim_player.play("attack")
		
	if attacking and anim_player.current_animation != "attack":
		attacking = false
	
	if !is_on_floor():
		if motion.y < 0:
			anim_player.play("jump")
		elif motion.y > 0:
			anim_player.play("fall")
	
	#motion.x = lerp(motion.x, float(MAXSPEED * (1 if motion.x > 0 else -1)), ACCEL / MAXSPEED)

	velocity = motion
	move_and_slide()
