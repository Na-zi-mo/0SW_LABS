extends Node2D

@export var velocity = Vector2()
@export var acceleration = Vector2()
@export var rotation_speed = 5.0
@export var move_speed = 200.0 
@export var distance_from_boids = 200


var shoot_interval = 1.0 / 4.0  # 5 balles par seconde
var time_since_last_shot = 0.0  # Chronomètre pour le tir


var mass : float = 1.0    
const top_speed = 200

@export var bullet_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func spawn() :
	var potential_spawn = Vector2(randf_range(50, get_viewport_rect().size.x -50), randf_range(50, get_viewport_rect().size.y-50))

	while !is_area_safe_to_spawn(potential_spawn):
		potential_spawn = Vector2(randf_range(50, get_viewport_rect().size.x -50), randf_range(50, get_viewport_rect().size.y-50))
	position = potential_spawn
	
func get_input(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("shoot"):
		if (time_since_last_shot >= shoot_interval) :
			shoot()
			time_since_last_shot = 0.0 
	
	if Input.is_action_pressed("left"):
		rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("right"):
		rotation += rotation_speed * delta
	
	if Input.is_action_pressed("forward"):		
		var direction = Vector2(cos(rotation), sin(rotation))
		#position += direction * move_speed * delta
		var force = direction * 2
		$Fire.visible = true
		apply_force(force)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	time_since_last_shot += delta  
	get_input(delta)
	$Fire.visible = false
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

func is_area_safe_to_spawn(potenital_spawn : Vector2):
	var close_boids_num = get_surrounding_nodes(potenital_spawn)
	return close_boids_num == 0

func get_surrounding_nodes(potenital_spawn : Vector2):
	var nodes = get_tree().get_nodes_in_group("ennemies")
	var close_nodes = []
	
	for node in nodes:
		var distance = potenital_spawn.distance_to(node.position)
		if distance < distance_from_boids :
			close_nodes.append(node)
	return close_nodes.size()

func _on_Player_body_entered(body: Node2D) -> void:
	if body.is_in_group("ennemies"):
		spawn()
