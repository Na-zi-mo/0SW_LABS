extends Node2D

var speed = 750

# Signal émis lorsque le bullet est hors de l'écran
signal bullet_out_of_screen

func _physics_process(delta):
	# Déplacement du projectile
	if visible:
		position += transform.x * speed * delta
		if  is_out_of_screen():
			bullet_out_of_screen.emit(self)
			emit_signal("bullet_out_of_screen")

func _on_Bullet_body_entered(body: Node2D):
	# Vérifier la collision avec les ennemis (ou autres objets)
	if visible:
		if body.is_in_group("ennemies"):
			body.queue_free()  # Supprimer l'ennemi touché
		bullet_out_of_screen.emit(self)

func is_out_of_screen() -> bool:
	var screen_rect = get_viewport_rect()
	return position.x < 0 or position.x > screen_rect.size.x or position.y < 0 or position.y > screen_rect.size.y
