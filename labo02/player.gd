extends Node2D

@export var velocity = Vector2()
@export var rotation_speed = 2.0
@export var move_speed = 200.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_spawn()

func _spawn() -> void:
	position = Vector2(randf_range(50, 350), randf_range(50, 350))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("forward"):		
		var direction = Vector2(cos(rotation), sin(rotation)).rotated(-PI / 2)
		position += direction * move_speed * delta
