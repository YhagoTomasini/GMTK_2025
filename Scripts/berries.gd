extends Area2D

var capturado : bool = false

var posiTeia : Area2D

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if capturado:
		position = posiTeia.global_position


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		capturado = true
		area.coletar = true
		posiTeia = area
		
		#await get_tree().create_timer(3)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		Globals.berries += 1
		queue_free()
