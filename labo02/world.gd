extends Node2D

@export var max_boids : int = 20
@export_range(3, 500, 2) var num_boids : int = randi_range(10,20)  # Nombre cible de boids

@export var debugging : bool = false :
	set(value) :
		debugging = value
		set_debug()

@export var enable_separation : bool = false :
	set(value) :
		enable_separation = value
		update_forces()

@export var enable_alignment : bool = false  :
	set(value) :
		enable_alignment = value
		update_forces()

@export var enable_cohesion : bool = false  :
	set(value) :
		enable_cohesion = value
		update_forces()

@onready var boid_scene = preload("res://boid.tscn")

func _ready():
	randomize()  
	adjust_boids()  
	set_debug()
	update_forces()

func adjust_boids():
	var current_boids = get_children().filter(func(n): return n is Boid)
	var current_count = current_boids.size()

	if current_count < num_boids:
		add_boids(num_boids - current_count)
	elif current_count > num_boids:
		remove_boids(current_count - num_boids)

func add_boids(count: int):
	for i in range(count):
		var boid_instance = boid_scene.instantiate()
		boid_instance.position = Vector2(randi_range(0, get_viewport_rect().size.x), randi_range(0, get_viewport_rect().size.y))
		add_child(boid_instance)
		if count == 1:
			boid_instance.change_color()
		

func remove_boids(count: int):
	var current_boids = get_children().filter(func(n): return n is Boid)
	for i in range(count):
		var random_boid = current_boids[randi_range(0, current_boids.size() - 1)]
		current_boids.erase(random_boid)
		random_boid.queue_free()

func set_debug():
	if not is_node_ready() : return
	
	var current_boids = get_children().filter(func(n): return n is Boid)
	
	for i in range(num_boids):
		if (i != 0) :
			current_boids[i].set_debug(debugging)
			current_boids[i].is_chosen = false
		else :
			current_boids[0].is_chosen = debugging
	

func _physics_process(delta):
	manage_inputs()
	#print(get_children().filter(func(n): return n is Boid).size())

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if max_boids > get_children().filter(func(n): return n is Boid).size():
				add_boids(1)
				num_boids+=1

func manage_inputs() -> void :
	if (Input.is_action_just_pressed("quit")):
		get_tree().quit()
	
	if (Input.is_action_just_pressed("toggle_debug")):
		debugging = !debugging

func update_forces() -> void :
	var current_boids = get_children().filter(func(n): return n is Boid)
	for boid in current_boids:
		boid.has_cohesion = enable_cohesion
		boid.has_alignment = enable_alignment
		boid.has_separation = enable_separation
