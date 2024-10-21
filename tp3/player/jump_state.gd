extends BaseState
class_name PlayerJump

@export var player : Player
var state_machine : AnimationNodeStateMachinePlayback 
@export var JUMPFORCE = 400
@export var ACCEL = 75.0

func manage_input() -> int:	
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	return dir

func enter():
	
	
	state_machine = player.get_state_machine()
	player.state_machine.travel("jump")

	player.motion.y = -JUMPFORCE
	

func update(delta : float) -> void:
	if not state_machine:
		state_machine = player.get_state_machine()
	
	var dir := manage_input()
	if dir > 0:
		player.facing_right = true
	elif dir < 0:
		player.facing_right = false
	player.motion.x = ACCEL * dir
	
	if player.velocity.y >= 0 :
		Transitioned.emit(self, "fall")
	

func physics_update(delta: float) -> void:
	pass
