extends Control

@onready var scroll_container: ScrollContainer = $ScrollContainer

@export var text_node: RichTextLabel
@export var vel : float = 1

var cabo : bool = false


func _ready() -> void:
	pass
	
func fim():
	cabo = true
	print("fim")
	
func _process(delta: float) -> void:
	if scroll_container.scroll_vertical <= text_node.size.y + 720:
		scroll_container.scroll_vertical += 1 * vel
	elif !cabo:
		fim()
