extends Node2D

@export_range(3, 500, 2) var num_boids : int = 20  # Nombre cible de boids

@onready var boid_scene = preload("res://boid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()  
	adjust_boids() 

func adjust_boids():
	var current_boids = get_children().filter(func(n): return n is Boid)
	var current_count = current_boids.size()

	if current_count < num_boids:
		add_boids(num_boids - current_count)
	elif current_count > num_boids:
		remove_boids(current_count - num_boids)

# Ajouter les boids manquants
func add_boids(count: int):
	for i in range(count):
		var boid_instance = boid_scene.instantiate()
		boid_instance.position = Vector2(randi_range(0, get_viewport_rect().size.x), randi_range(0, get_viewport_rect().size.y))
		add_child(boid_instance)

func remove_boids(count: int):
	var current_boids = get_children().filter(func(n): return n is Boid)
	for i in range(count):
		var random_boid = current_boids[randi_range(0, current_boids.size() - 1)]
		current_boids.erase(random_boid)
		random_boid.queue_free()

func _process(delta: float) -> void:
	#print(get_children().filter(func(n): return n is Boid).size())
	if num_boids != get_children().filter(func(n): return n is Boid).size():
		adjust_boids()
		
