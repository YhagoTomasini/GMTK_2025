extends Area2D

var speed : int = 175

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.chuva_a_derrubou()
		await get_tree().create_timer(0.1).timeout
		queue_free()
		#get_tree().reload_current_scene()
		print("A chuva forte a derrubou")
