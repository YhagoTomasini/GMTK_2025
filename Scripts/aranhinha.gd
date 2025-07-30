extends CharacterBody2D


const SPEED = 300.0
var started : bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		started = true
		
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if started:
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
		
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	move_and_slide()
