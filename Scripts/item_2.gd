extends Button

@export var custo : int
@onready var custoLabel: Label = $custo


func _ready() -> void:
	pass
	
func updateCusto():
	print("cutoso")
	custo += Globals.cMoth

func _process(_delta: float) -> void:
	custoLabel.text = str(custo)

func _on_button_down() -> void:
	ativarEfeito()
	
func ativarEfeito():
	if Globals.berries >= custo:
		Globals.casulosEstoque += 1
		Globals.cMoth += 1
		Globals.berries -= custo
		
		get_parent().get_parent().get_parent().selectItem()
		
		await get_tree().create_timer(0.1).timeout
		queue_free()
	else:
		modulate = Color(0.7, 0.2, 0.2, 1)
		await get_tree().create_timer(0.3).timeout
		modulate = Color(1, 1, 1, 1)
