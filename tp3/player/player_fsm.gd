extends CharacterBody2D

class_name Player

@export var GRAVITY = 10
@export var MAXFALLSPEED = 200
@export var MAXSPEED = 200
@export var JUMPFORCE = 350

const ACCEL = 75.0

var facing_right : bool = true
var dir : float = 0.0
var motion = Vector2()

var current_sprite : Sprite2D
var anim_player : AnimationPlayer 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player = $AnimationPlayer
	current_sprite = $Sprite2D
	anim_player.play("idle")

# Called every physics frame
func _physics_process(delta: float) -> void:
	current_sprite.flip_h = !facing_right
	
	motion.y += GRAVITY
	
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	velocity = motion
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player
