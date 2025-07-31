extends Area2D


var speed : int = 50

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.queue_free()
