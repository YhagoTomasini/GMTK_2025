extends StaticBody2D

const TEIA_PATH = preload("res://Prefarbs/teia_path.tscn")

func _ready() -> void:
	pass
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		area.queue_free()
		
		var teia_path = TEIA_PATH.instantiate()
		get_parent().add_child(teia_path)
		teia_path.position = position
		
		await get_tree().create_timer(0.1).timeout
		queue_free()
		
