extends Area2D

@onready var sprite: Sprite2D = $sprite

func _ready() -> void:
	var rot = randf_range(0, 360)
	sprite.rotation = rot
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.nChiclete += 1
		body.is_slow = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.nChiclete -= 1
		if body.nChiclete <= 0:
			body.is_slow = false
		
