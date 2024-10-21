extends CharacterBody2D

class_name Player

const GRAVITY = 10
const MAXFALLSPEED = 200
const MAXSPEED = 200
const JUMPFORCE = 350

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
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player
