extends Control

@onready var controls_panel: Control = $ControlsPanel
@onready var startButton: Button = $VBoxContainer/Start
@onready var controls_Button: Button = $ControlsPanel/CloseControlsP


func _ready() -> void:
	startButton.grab_focus()
	controls_panel.visible = false


func _process(delta: float) -> void:
	pass


func _on_start_button_down() -> void:
	get_tree().change_scene_to_file("res://Scene/main.tscn")


func _on_controls_button_down() -> void:
	controls_panel.visible = true
	controls_Button.grab_focus()


func _on_quit_button_down() -> void:
	pass # Replace with function body.


func _on_close_controls_p_button_down() -> void:
	controls_panel.visible = false
	startButton.grab_focus()
