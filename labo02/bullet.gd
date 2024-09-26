#extends Node2D
#
#var speed = 750
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
	#position += transform.x * speed * delta
	
#func _on_Bullet_body_entered(body: Node2D) -> void:
	#if body.is_in_group("ennemies"):
		#body.queue_free()
	#queue_free()


extends Node2D

var speed = 750


@onready var area = $Area2D
# Signal émis lorsque le bullet est hors de l'écran
signal bullet_out_of_screen

#func _ready() -> void:
	#area.collision_layer  = 1  # Bullet layer
	#$Area2D.collision_mask = 2  # Enemy layer
	#$Area2D.colli


func _physics_process(delta):
	# Déplacement du projectile
	if visible:
		position += transform.x * speed * delta
		#var result =
		if  is_out_of_screen():
			#print("true")
			#emit_signal("bullet_out_of_screen")
			bullet_out_of_screen.emit(self)
			#emit_signal("bullet_out_of_screen")
	# Si le projectile est hors de l'écran, émettre le signal
	
	
#func _on_Bullet_body_entered(body: Node2D) -> void:
	#if body.is_in_group("ennemies"):
		#body.queue_free()
	#queue_free()
#func _on_Bullet_body_entered(body):
	## Vérifier la collision avec les ennemis (ou autres objets)
	#if body.is_in_group("ennemies"):
		#body.queue_free()  # Supprimer l'ennemi touché
	#emit_signal("bullet_out_of_screen")  # Émettre le signal pour recycler le projectile



func _on_Bullet_body_entered(body: Node2D):
	# Vérifier la collision avec les ennemis (ou autres objets)
	if visible:
	#print(body.get_groups())
		if body.is_in_group("ennemies"):
			body.queue_free()  # Supprimer l'ennemi touché
		#emit_signal("bullet_out_of_screen")  # Émettre le signal pour recycler le projectile
		bullet_out_of_screen.emit(self)
	#emit_signal("bullet_out_of_screen")

func is_out_of_screen() -> bool:
	#print("Out of screen")
	var screen_rect = get_viewport_rect()
	return position.x < 0 or position.x > screen_rect.size.x or position.y < 0 or position.y > screen_rect.size.y
