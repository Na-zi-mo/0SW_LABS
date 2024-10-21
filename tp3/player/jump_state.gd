extends BaseState
class_name PlayerJump

@export var player : Player
var state_machine : AnimationNodeStateMachinePlayback 
@export var JUMPFORCE = 400

	
func enter():
	state_machine = player.get_state_machine()
	player.state_machine.travel("jump")
	player.motion.y = -JUMPFORCE
	

func update(delta : float) -> void:
	if not state_machine:
		state_machine = player.get_state_machine()
	
	if player.velocity.y >= 0 :
		Transitioned.emit(self, "fall")
	

func physics_update(delta: float) -> void:
	pass
