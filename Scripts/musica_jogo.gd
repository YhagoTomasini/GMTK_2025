extends Node2D

@onready var tema: AudioStreamPlayer2D = $tema

var tocando : bool

func _ready() -> void:
	tocando = false
	
func tocar():
	if !tocando:
		tema.play()
		tocando = true
	
func parar():
	tema.stop()
	tocando = false

func _process(delta: float) -> void:
	pass
	#if get_tree().current_scene != null:
		#var cenaAtual = get_tree().current_scene.name
		#if cenaAtual in ["shop", "main"] and tocando:
			##if !tocando:
			#tema.play()
		#else:
			#parar()
			
