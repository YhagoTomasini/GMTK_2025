extends Control

@onready var slots: Array = $GridContainer.get_children()
@export var itens: Array[PackedScene]

func _ready() -> void:
	for slot in slots:
		var produtoID = randi() % itens.size()
		var produto = itens[produtoID].instantiate()
		
		slot.add_child(produto)
		
func _process(delta: float) -> void:
	pass
