extends BaseState
class_name PlayerFall

@export var player : Player
var anim_player : AnimationPlayer

const JUMPFORCE = 350
const GRAVITY = 10
const MAXFALLSPEED = 200
const MAXSPEED = 200
	
func enter():
	anim_player = player.get_animation_player()
	#player.motion.y = -JUMPFORCE
	

func update(delta : float) -> void:
	#player.motion.y += GRAVITY
	if not anim_player :
		anim_player = player.get_animation_player()
	
	if player.is_on_floor() :
		Transitioned.emit(self, "idle")
	
	

func physics_update(delta: float) -> void:
	if not player.is_on_floor() :
		anim_player.play("fall")
		
