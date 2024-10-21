extends BaseState
class_name PlayerWalk

@export var player : Player
var anim_player : AnimationPlayer

@export var ACCEL = 75.0

func manage_input() -> int:	
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");

	
	return dir

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()

	var dir := manage_input()
	
	player.motion.x = ACCEL * dir
	if dir > 0:
		player.facing_right = true
	elif dir < 0:
		player.facing_right = false
	else:
		Transitioned.emit(self, "idle")
		
	if not player.is_on_floor() and player.velocity.y > 0 :
		Transitioned.emit(self, "fall")
		
	if player.is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		Transitioned.emit(self, "jump")
	elif player.is_on_floor() and Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "attack")

func physics_update(delta: float) -> void:
	var dir := manage_input()
	
	if (player.velocity.length() > 0) :
		anim_player.play("walk")
