extends Control

@onready var slots: Array = $GridContainer.get_children()
@export var itens: Array[PackedScene]

@onready var botaoSair: Button = $Button
@onready var shop_slot_1: Panel = $GridContainer/ShopSlot1
@onready var shop_slot_2: Panel = $GridContainer/ShopSlot2
@onready var shop_slot_3: Panel = $GridContainer/ShopSlot3
@onready var shop_slot_4: Panel = $GridContainer/ShopSlot4
@onready var text_berries: Label = $BerriesCounter/TextBerries


func _ready() -> void:
	for slot in slots:
		var produtoID = randi() % itens.size()
		var produto = itens[produtoID].instantiate()
		
		slot.add_child(produto)
		
	selectItem()
	
func selectItem():
	botaoSair.grab_focus()
		
	for slot in slots:
		if slot.get_child_count() > 0:
			var produto = slot.get_child(0)
			produto.updateCusto()
	

func _process(_delta: float) -> void:
	text_berries.text = str(Globals.berries)
	
	if Input.is_action_just_pressed("ui_cancel"):
		voltarMain()

func _on_button_button_down() -> void:
	voltarMain()
	
func voltarMain():
	get_tree().change_scene_to_file("res://Scene/main.tscn")
