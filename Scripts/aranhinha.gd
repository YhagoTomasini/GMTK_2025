extends CharacterBody2D

const sceneTeia = preload("res://Prefarbs/teia.tscn")
@onready var cam: Camera2D = $"../Camera2D"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collisionArana: CollisionShape2D = $CollisionArana
@onready var anim_sprite: AnimatedSprite2D = $animSprite
@onready var visual_cd_teia: Sprite2D = $"../HUD/Control/VisualCDTeia"


var speedRotation : float = 5
var cdTeia : float = 3
var cdTime : float = 0
var speed = 160.0

#BOOLEANAS
var shop : bool
var vaiTeia : bool
var podeCasulo : bool
var foraDaCasinha : bool

func _ready() -> void:
	shop = false
	vaiTeia = true
	podeCasulo = true
	foraDaCasinha = true

func podeTeia():
	vaiTeia = false
	visual_cd_teia.modulate = Color(1, 0.5, 0.5, 0.5)
	await get_tree().create_timer(cdTeia).timeout
	visual_cd_teia.modulate = Color(0.5, 1, 0.5, 0.5)
	vaiTeia = true

func cuspir():
	podeTeia()
	var projetil = sceneTeia.instantiate()
	projetil.aranha = $"."
	get_parent().add_child(projetil)
	projetil.global_rotation = rotation
	projetil.global_position = position + Vector2.RIGHT.rotated(rotation) * 16

func casulo():
	foraDaCasinha = false
	collisionArana.disabled = true
	sprite_2d.modulate = Color(0, 0, 0, 255)
	
	await get_tree().create_timer(5).timeout
	collisionArana.disabled	= false
	foraDaCasinha = true
	sprite_2d.modulate = Color(255, 255, 255, 255)
	

func _physics_process(delta: float) -> void:
	#Movimentacao da CAMERA
	#if position.y <= cam.position.y:
	cam.position.y = position.y
	
	#COOLDOWN TEIA
	if !vaiTeia:
		cdTime += delta
		var t = clamp(cdTime / cdTeia, 0, 1)
		visual_cd_teia.scale.y = t
	else:
		cdTime = 0
		visual_cd_teia.scale.y = 1
		
	if foraDaCasinha:
	#TEIA
		if vaiTeia and Input.is_action_just_pressed("ui_accept") and !shop:
			cuspir()
			
		
		if podeCasulo and Input.is_action_just_pressed("ui_cancel"):
			casulo()
	
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
#ADICIONANDO ANIMAÇAO
			if anim_sprite.animation != "Runinng":
				anim_sprite.play("Runinng")
		else:
			anim_sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		shop = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Aranhinha":
		shop = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		area.queue_free()
