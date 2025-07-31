extends Control

@onready var slots: Array = $GridContainer.get_children()
@export var itens: Array[PackedScene]

func _ready() -> void:
	for slot in slots:
		var produtoID = randi() % itens.size()
		var produto = itens[produtoID].instantiate()
		
		slot.add_child(produto)
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		voltarMain()


func _on_button_button_down() -> void:
	voltarMain()
	
func voltarMain():
	get_tree().change_scene_to_file("res://Scene/main.tscn")
