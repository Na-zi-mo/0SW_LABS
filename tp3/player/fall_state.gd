extends BaseState
class_name PlayerFall

@export var player : Player
var state_machine : AnimationNodeStateMachinePlayback 
	
@export var ACCEL = 75.0
	
func enter():
	state_machine = player.get_state_machine()

func manage_input() -> int:	
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")	
	return dir
	
func update(delta : float) -> void:
	if not state_machine:
		state_machine = player.get_state_machine()
	
	var dir := manage_input()
	if dir > 0:
		player.facing_right = true
	elif dir < 0:
		player.facing_right = false
	player.motion.x = ACCEL * dir
	
	if player.is_on_floor() :
		Transitioned.emit(self, "idle")
	
func physics_update(delta: float) -> void:
	if not player.is_on_floor() :
		state_machine.travel("fall")
