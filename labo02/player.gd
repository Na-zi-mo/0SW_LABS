extends Node2D

@export var velocity = Vector2()
@export var acceleration = Vector2()
@export var rotation_speed = 2.0
@export var move_speed = 200.0 
var mass : float = 1.0    
const top_speed = 200

@export var bullet_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	
	spawn()

func spawn() :
	position = Vector2(randf_range(50, get_viewport_rect().size.x -50), randf_range(50, get_viewport_rect().size.y-50))
	#position = Vector2(150,150)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	$Fire.visible = false
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("forward"):		
		var direction = Vector2(cos(rotation), sin(rotation))
		#position += direction * move_speed * delta
		var force = direction * 1.5
		$Fire.visible = true
		apply_force(force)
	
	update_position(delta)
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

func apply_force(force: Vector2):
	acceleration += force / mass  

func update_position(delta):
	velocity += acceleration  
	velocity = velocity.limit_length(top_speed)  
	position += velocity * delta
	acceleration = Vector2()

func shoot():
	var b = bullet_scene.instantiate()
	get_parent().add_child(b)
	b.global_transform = $Muzzle.global_transform
