extends Control

@onready var slots: Array = $GridContainer.get_children()
@export var itens: Array[PackedScene]

@onready var botaoSair: Button = $Button
@onready var shop_slot_1: Panel = $GridContainer/ShopSlot1
@onready var shop_slot_2: Panel = $GridContainer/ShopSlot2
@onready var shop_slot_3: Panel = $GridContainer/ShopSlot3
@onready var shop_slot_4: Panel = $GridContainer/ShopSlot4


func _ready() -> void:
	for slot in slots:
		var produtoID = randi() % itens.size()
		var produto = itens[produtoID].instantiate()
		
		slot.add_child(produto)
		
	selectItem()
	
func selectItem():
	#if shop_slot_1.get_child_count() != null:
		#shop_slot_1.get_child(0).grab_focus()
	#else:
		#if shop_slot_2.get_child_count() != null:
			#shop_slot_2.get_child(0).grab_focus()
		#else:
			#if shop_slot_3.get_child_count() != null:
				#shop_slot_3.get_child(0).grab_focus()
			#else:
				#if shop_slot_4.get_child_count() != null:
					#shop_slot_4.get_child(0).grab_focus()
				#else:
	botaoSair.grab_focus()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		voltarMain()
	
	#if shop_slot_1.get_child_count() == null:
		#selectItem()
	#if shop_slot_2.get_child_count() == null:
		#selectItem()
	#if shop_slot_3.get_child_count() == null:
		#selectItem()
	#if shop_slot_4.get_child_count() == null:
		#selectItem()

func _on_button_button_down() -> void:
	voltarMain()
	
func voltarMain():
	get_tree().change_scene_to_file("res://Scene/main.tscn")
