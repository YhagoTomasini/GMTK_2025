extends CharacterBody2D

@onready var anim: AnimationPlayer = $anim
@onready var timer: Timer = $Timer

var vivo : bool = true

func _ready() -> void:
	timer.wait_time = randf_range(2.0, 8.0)
	


	
func _process(_delta: float) -> void:
	#if damage_area.is_colliding():
		#print("papou a aranha")
	pass

func sapo_ao_ataque():
	if vivo:
		anim.play("linguada")
	else:
		anim.play("calado")
	
func _on_timer_timeout() -> void:
	sapo_ao_ataque()
	timer.wait_time = randf_range(2.0, 8.0)

func _on_anim_animation_finished(_anim_name: StringName) -> void:
	anim.play("idle")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		anim.play("calado")
		vivo = false
		
func _on_linguinha_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		get_tree().call_deferred("reload_current_scene")
		print("papou a aranha")
	else:
		pass
