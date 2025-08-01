extends Node2D

@onready var anim: AnimationPlayer = $anim
@onready var chuva: GPUParticles2D = $chuva
@onready var spwan_rain: Marker2D = $spwan_rain
const LIMPADOR = preload("res://Prefarbs/limpador.tscn")

var barra = LIMPADOR

func chuva_forte():
	chuva.emitting = true
	anim.play("escurecendo")
	var veio_a_chuva = LIMPADOR.instantiate()
	get_tree().get_root().add_child(veio_a_chuva)
	veio_a_chuva.global_position = spwan_rain.global_position
	await get_tree().create_timer(6).timeout
	veio_a_chuva.queue_free()
	chuva.emitting = false
	anim.play("ficando_normal")

func _on_timer_timeout() -> void:
	chuva_forte()
	#await get_tree().create_timer(5).timeout
	#chuva.emitting = false
	#anim.play("ficando_normal")
	#barra.queue_free()
