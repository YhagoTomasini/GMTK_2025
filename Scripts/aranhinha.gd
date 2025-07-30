extends CharacterBody2D

const sceneTeia = preload("res://Scene/teia.tscn")
@onready var cam: Camera2D = $"../Camera2D"

var speedRotation : float = 5

var cdTeia : float = 5
var speed = 300.0

#BOOLEANAS
var shop : bool = false
var vaiTeia : bool = true

func _ready() -> void:
	pass

func podeTeia():
	vaiTeia = false
	await get_tree().create_timer(cdTeia).timeout
	vaiTeia = true

func cuspir():
	var projetil = sceneTeia.instantiate()
	get_parent().add_child(projetil)
	projetil.position = position
	projetil.rotation = rotation

func _physics_process(delta: float) -> void:
	#Movimentacao da CAMERA
	#if position.y <= cam.position.y:
	cam.position.y = position.y
	
	#TEIA
	if vaiTeia and Input.is_action_just_pressed("ui_accept") and !shop:
		cuspir()
	
	#Acesso a LOJA
	if shop:
		if Input.is_action_just_pressed("ui_accept"):
			print("Mudar de cena para a lolja")  
	
	#MOVIMENTACAO
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
	input_vector = input_vector.normalized()
	
	velocity = input_vector * speed
	move_and_slide()
	
	if input_vector.length() > 0.1:
		var direction = input_vector.angle()
		rotation = lerp_angle(rotation, direction, speedRotation * delta)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	shop = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	shop = false
