extends CharacterBody2D

@onready var anim: AnimationPlayer = $anim
@onready var timer: Timer = $Timer

@onready var damage_area: CollisionShape2D = $linguinha/damage_area
@onready var collider: CollisionShape2D = $collision


@onready var froging: AudioStreamPlayer2D = $froging
@onready var linguada_aud: AudioStreamPlayer2D = $linguadaAud

var vivo : bool = true

func _ready() -> void:
	timer.wait_time = randf_range(2.0, 8.0)
	
	froging.play()
	

func sapo_ao_ataque():
	if vivo:
		anim.play("linguada")
		await get_tree().create_timer(0.2).timeout
		linguada_aud.play()
		
	else:
		anim.play("idle")
	
func _on_timer_timeout() -> void:
	sapo_ao_ataque()
	timer.wait_time = randf_range(2.0, 8.0)

func _on_anim_animation_finished(_anim_name: StringName) -> void:
	anim.play("idle")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		vivo = false
		sapo_ao_ataque()
		
		damage_area.disabled = true
		collider.disabled = true
		timer.stop()
		
		var tween := get_tree().create_tween()
		tween.tween_property(self, "position:y", 636.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.parallel().tween_property(self, "rotation", rotation + TAU * 2, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		froging.stop()
		
		await tween.finished
		
		queue_free()
		
func _on_linguinha_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.chuva_a_derrubou()
		print("papou a aranha")
	else:
		pass
