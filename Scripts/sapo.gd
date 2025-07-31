extends CharacterBody2D

@onready var damage_area: RayCast2D = $damage_area
@onready var anim: AnimationPlayer = $anim

func _process(delta: float) -> void:
	if damage_area.is_colliding():
		print("papou a aranha")

func _on_timer_timeout() -> void:
	anim.play("linguada")

func _on_anim_animation_finished(anim_name: StringName) -> void:
	anim.play("idle")
