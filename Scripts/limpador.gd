extends Area2D

var speed : int = 100

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		await get_tree().create_timer(2).timeout
		queue_free()
		#get_tree().reload_current_scene()
		print("A chuva forte a derrubou")
