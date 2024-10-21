extends BaseState
class_name PlayerJump

@export var player : Player
var anim_player : AnimationPlayer

@export var JUMPFORCE = 400

	
func enter():
	anim_player = player.get_animation_player()
	player.motion.y = -JUMPFORCE
	

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	
	if player.velocity.y > 0 :
		Transitioned.emit(self, "fall")
	
	

func physics_update(delta: float) -> void:
	if (player.velocity.y < 0) :
		anim_player.play("jump")
		
