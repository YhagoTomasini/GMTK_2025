extends Button

@export var custo : int

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_button_down() -> void:
	if Globals.berries >= custo:
		Globals.casulosEstoque += 1
