extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.is_slow = true
	




func _on_body_exited(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.is_slow = false
		
