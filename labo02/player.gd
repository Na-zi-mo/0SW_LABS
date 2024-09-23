extends Node2D

@export var velocity = Vector2()
@export var rotation_speed = 2.0
@export var move_speed = 200.0 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	spawn()

func spawn() :
	position = Vector2(randf_range(50, get_viewport_rect().size.x), randf_range(50, get_viewport_rect().size.y))

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("forward"):		
		var direction = Vector2(cos(rotation), sin(rotation)).rotated(-PI / 2)
		position += direction * move_speed * delta
		
	wrap_around_screen()

func wrap_around_screen() :
	if position.x > get_viewport_rect().size.x:
		position.x = 0
	elif position.x < 0:
		position.x = get_viewport_rect().size.x

	if position.y > get_viewport_rect().size.y:
		position.y = 0
	elif position.y < 0:
		position.y = get_viewport_rect().size.y
