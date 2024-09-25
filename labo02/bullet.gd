extends Node2D

var speed = 750

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_Bullet_body_entered(body: Node2D) -> void:
	if body.is_in_group("ennemies"):
		body.queue_free()
	queue_free()
