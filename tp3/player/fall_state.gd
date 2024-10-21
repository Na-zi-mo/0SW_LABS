extends BaseState
class_name PlayerFall

@export var player : Player
var anim_player : AnimationPlayer

	
func enter():
	anim_player = player.get_animation_player()
	

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	
	if player.is_on_floor() :
		Transitioned.emit(self, "idle")
	
	

func physics_update(delta: float) -> void:
	if not player.is_on_floor() :
		anim_player.play("fall")
		
