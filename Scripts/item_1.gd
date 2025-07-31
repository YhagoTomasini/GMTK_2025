extends Button

@export var custo : int

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_button_down() -> void:
	if Globals.berries >= custo:
		Globals.speed += Globals.speed*0.1
		await get_tree().create_timer(0.1).timeout
		queue_free()
