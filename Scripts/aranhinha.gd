extends CharacterBody2D

@onready var cam: Camera2D = $"../Camera2D"

const SPEED = 300.0
var shop : bool = false


func _physics_process(_delta: float) -> void:
	#if position.y <= cam.position.y:
	cam.position.y = position.y
	
	if shop:
		if Input.is_action_just_pressed("ui_accept"):
			print("Mudar de cena para a lolja")  
		
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
		
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	move_and_slide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	shop = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	shop = false
