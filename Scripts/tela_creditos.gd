extends ScrollContainer

@export var text_node: RichTextLabel

@export var vel : float = 1

var cabo : bool = false
#@export_range(1, 100000, 0.1) var creditsTempo : float = 1
#@export_range(0, 100000, 0.1) var margin_incremet : float = 0

#@onready var margin_container: MarginContainer = $MarginContainer


func _ready() -> void:
	pass
	#text_node.fit_content = true
	#
	#await get_tree().process_frame
	#
	#var tween = create_tween()
	#
	#await get_tree().create_timer(0.1).timeout
	#
	#var text_box_size = text_node.size.y
	#var window_size = DisplayServer.window_get_size().y
	#margin_container.add_theme_constant_override("margin_top", window_size + margin_incremet)
	#margin_container.add_theme_constant_override("margin_bottom", window_size + margin_incremet)
	#
	#var scroll_amount = ceil(text_box_size * 3/4 + window_size * 2 + margin_incremet)
	#
	#tween.tween_property(self, "scroll_vertical", scroll_amount, creditsTempo)
	#
	#tween.finished.connect(fim)
	#tween.play()
	
func fim():
	cabo = true
	print("fim")
	
func _process(delta: float) -> void:
	if scroll_vertical <= text_node.size.y + 720 * 2:
		scroll_vertical += 1 * vel
	elif !cabo:
		fim()
