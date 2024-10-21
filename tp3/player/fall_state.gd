extends BaseState
class_name PlayerFall

@export var player : Player
var state_machine : AnimationNodeStateMachinePlayback 
	
func enter():
	state_machine = player.get_state_machine()
	
func update(delta : float) -> void:
	if not state_machine:
		state_machine = player.get_state_machine()
	
	if player.is_on_floor() :
		Transitioned.emit(self, "idle")
	
func physics_update(delta: float) -> void:
	if not player.is_on_floor() :
		state_machine.travel("fall")
