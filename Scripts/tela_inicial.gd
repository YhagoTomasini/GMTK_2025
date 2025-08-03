extends Control

@onready var controls_panel: Control = $ControlsPanel
@onready var startButton: Button = $VBoxContainer/Start
@onready var controls_Button: Button = $ControlsPanel/CloseControlsP
@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	MusicaJogo.parar()
	startButton.grab_focus()
	controls_panel.visible = false

func _process(delta: float) -> void:
	pass

func _on_start_button_down() -> void:
	get_tree().change_scene_to_file("res://Scene/main.tscn")


func _on_controls_button_down() -> void:
	controls_panel.visible = true
	color_rect.color = Color(47/255, 47/255, 84/255, 127.7/255)
	controls_Button.grab_focus()


func _on_quit_button_down() -> void:
	get_tree().quit()
	print("Saiu do jogo")


func _on_close_controls_p_button_down() -> void:
	controls_panel.visible = false
	color_rect.color = Color(47/255, 47/255, 84/255, 63/255)
	startButton.grab_focus()


func _on_creditos_button_down() -> void:
	get_tree().change_scene_to_file("res://Scene/tela_final.tscn")
