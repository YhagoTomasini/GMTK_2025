extends Node2D

@onready var anim: AnimationPlayer = $anim
@onready var chuva: GPUParticles2D = $chuva
@onready var spwan_rain: Marker2D = $spwan_rain
const LIMPADOR = preload("res://Prefarbs/limpador.tscn")

var barra = LIMPADOR
var tempo_de_chuva : int 

@onready var chuva_aud: AudioStreamPlayer2D = $chuvaAud
@onready var trovao_aud: AudioStreamPlayer2D = $trovaoAud

var trovoesAud := [
	preload("res://Audios/trovao1.wav"),
	preload("res://Audios/trovao2.wav"),
	preload("res://Audios/trovao3.wav"),
]

#func _ready() -> void:
	#chuva_aud.volume_db = -10.0
	
func spawn_da_chuva():
	tempo_de_chuva = randi_range(8,12)
	await get_tree().create_timer(tempo_de_chuva).timeout
	chuva_aud.volume_db = -7
	chuva_forte()


func chuva_forte():
	chuva_aud.play()
	chuva.emitting = true
	anim.play("escurecendo")
	var veio_a_chuva = LIMPADOR.instantiate()
	get_tree().get_root().add_child(veio_a_chuva)
	veio_a_chuva.global_position = spwan_rain.global_position
	
	await get_tree().create_timer(2).timeout
	
	var trovaoNow = trovoesAud.pick_random()
	trovao_aud.stream = trovaoNow
	trovao_aud.play()
	
	chuva_aud.volume_db = -10.0
	
	await get_tree().create_timer(3).timeout

	spawn_da_chuva()
	if veio_a_chuva != null:
		veio_a_chuva.queue_free()
	chuva.emitting = false
	anim.play("ficando_normal")
	
	await get_tree().create_timer(1).timeout
	
	chuva_aud.stop()
	

#func _on_timer_timeout() -> void:
	#chuva_forte()
	#await get_tree().create_timer(5).timeout
	#chuva.emitting = false
	#anim.play("ficando_normal")
	#barra.queue_free()
