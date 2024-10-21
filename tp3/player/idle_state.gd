extends BaseState
class_name PlayerIdle

@export var player : Player
var anim_player : AnimationPlayer

func manage_input() -> void:	
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	
	if dir != 0:
		Transitioned.emit(self, "walk")
	elif Input.is_action_just_pressed("ui_accept"):
		Transitioned.emit(self, "jump")
	

func enter():
	anim_player = player.get_animation_player()
	
func update(delta: float) -> void:
	player.motion = player.motion.lerp(Vector2.ZERO, 0.2)
	
	if not player.is_on_floor() and player.velocity.y > 0 :
		Transitioned.emit(self, "fall")
	
	if not anim_player :
		anim_player = player.get_animation_player()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
		
	anim_player.play("idle")
