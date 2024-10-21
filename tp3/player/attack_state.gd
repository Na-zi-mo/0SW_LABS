extends BaseState
class_name PlayerAttack

@export var player : Player
var state_machine : AnimationNodeStateMachinePlayback 


func enter():
	state_machine = player.get_state_machine()
	state_machine.travel("attack")
	
func update(delta: float) -> void:
	if state_machine.get_current_node() != "attack":
		Transitioned.emit(self, "idle")
	
func physics_update(delta: float) -> void:
	if not state_machine : return
