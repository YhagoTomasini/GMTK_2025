extends Button

@export var custo : int

func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	pass

func _on_button_down() -> void:
	ativarEfeito()
	
func ativarEfeito():
	if Globals.berries >= custo:
		Globals.teiasEstoque += 1
		
		get_parent().get_parent().get_parent().selectItem()
		
		await get_tree().create_timer(0.1).timeout
		queue_free()
