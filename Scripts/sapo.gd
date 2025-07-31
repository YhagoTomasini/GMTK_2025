extends CharacterBody2D

@onready var damage_area: RayCast2D = $damage_area
@onready var anim: AnimationPlayer = $anim
@onready var timer: Timer = $Timer

var vivo : bool = true


func _process(delta: float) -> void:
	#if damage_area.is_colliding():
		#print("papou a aranha")
	pass

func sapo_ao_ataque():
	if vivo:
		anim.play("linguada")
		if damage_area.is_colliding():
			print("papou a aranha")
	else:
		anim.play("calado")
	
func _on_timer_timeout() -> void:
	sapo_ao_ataque()

func _on_anim_animation_finished(anim_name: StringName) -> void:
	anim.play("idle")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		anim.play("calado")
		vivo = false
