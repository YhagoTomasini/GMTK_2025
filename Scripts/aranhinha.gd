extends CharacterBody2D

const sceneTeia = preload("res://Prefarbs/teia.tscn")
@onready var cam: Camera2D = $"../Camera2D"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collisionArana: CollisionShape2D = $CollisionArana
@onready var anim_sprite: AnimatedSprite2D = $animSprite
@onready var visual_cd_teia: Sprite2D = $"../HUD/Control/VisualCDTeia"
@onready var visual_cd_casulo: Sprite2D = $"../HUD/Control/VisualCDCasulo"
#TEXTS
@onready var text_berries: Label = $"../HUD/Control/TextBerries"
@onready var text_casulos: Label = $"../HUD/Control/TextCasulos"
@onready var text_teias: Label = $"../HUD/Control/TextTeias"

#VARIAVEIS
var cdTimeTeia : float = 0
var cdTimeCasulo : float = 0

#BOOLEANAS
var shop : bool
var vaiTeia : bool
var comCasulo : bool
var foraDaCasinha : bool
var teiaReturn : bool

#SLOW
var is_slow : bool = false
var nChiclete : int 


func _ready() -> void:
	Globals.casulos = Globals.casulosEstoque
	text_casulos.text = str(Globals.casulos)
	
	Globals.teias = Globals.teiasEstoque
	text_teias.text = str(Globals.teias)
	
	nChiclete = 0
	
	shop = false
	vaiTeia = true
	comCasulo = true
	foraDaCasinha = true

func podeTeia():
	visual_cd_teia.modulate = Color(1, 0.5, 0.5, 0.5)
	
	await get_tree().create_timer(Globals.cdTeia).timeout
	visual_cd_teia.modulate = Color(0.5, 1, 0.5, 0.5)
	Globals.teias += 1
	text_teias.text = str(Globals.teias)
	vaiTeia = true

func cuspir():
	Globals.teias -= 1
	text_teias.text = str(Globals.teias)
	teiaReturn = false
	var projetil = sceneTeia.instantiate()
	projetil.aranha = $"."
	get_parent().add_child(projetil)
	projetil.global_rotation = rotation
	projetil.global_position = position + Vector2.RIGHT.rotated(rotation) * 16
	
	await get_tree().create_timer(0.2).timeout
	teiaReturn = true

func generateCasulo():
	visual_cd_casulo.modulate = Color(1, 0.5, 0.5, 0.5)
	
	await get_tree().create_timer(Globals.cdCasulo).timeout
	visual_cd_casulo.modulate = Color(0.5, 1, 0.5, 0.5)
	Globals.casulos += 1
	text_casulos.text = str(Globals.casulos)
	comCasulo = true

func casulo():
	Globals.casulos -= 1
	text_casulos.text = str(Globals.casulos)
	foraDaCasinha = false
	collisionArana.disabled = true
	sprite_2d.modulate = Color(0, 0, 0, 1)
	anim_sprite.play("Casulo")
	
	await get_tree().create_timer(3).timeout
	anim_sprite.play("Descasulo")
	
	await get_tree().create_timer(1).timeout
	foraDaCasinha = true
	collisionArana.disabled = false
	sprite_2d.modulate = Color(1, 1, 1, 1)
	
	
func _physics_process(delta: float) -> void:
	#Movimentacao da CAMERA
	if position.y <= cam.position.y:
		cam.position.y = position.y
	
	text_berries.text = str(Globals.berries)
	
	#COOLDOWN TEIA
	if !vaiTeia:
		cdTimeTeia += delta
		var t = clamp(cdTimeTeia / Globals.cdTeia, 0, 1)
		visual_cd_teia.scale.y = t
	else:
			cdTimeTeia = 0
			visual_cd_teia.scale.y = 1
	
	if vaiTeia and Globals.teias == 0:
		podeTeia()
		vaiTeia = false
	
	#COOLDOWN CASULO
	if !comCasulo:
		cdTimeCasulo += delta
		var t = clamp(cdTimeCasulo / Globals.cdCasulo, 0, 1)
		visual_cd_casulo.scale.y = t
	else:
		cdTimeCasulo = 0
		visual_cd_casulo.scale.y = 1
		
	if comCasulo and Globals.casulos == 0:
		generateCasulo()
		comCasulo = false
		
	#SE N ESTIVER NO CASULO
	if foraDaCasinha:
		
	#TEIA
		if vaiTeia and Input.is_action_just_pressed("ui_accept") and !shop:
			cuspir()
		
	#CASULO
		if comCasulo and Input.is_action_just_pressed("ui_cancel") and Globals.casulos >= 1:
			casulo()
	
	#Acesso a LOJA
		if shop:
			if Input.is_action_just_pressed("ui_accept"):
				get_tree().call_deferred("change_scene_to_file", "res://Scene/shop.tscn")
	
	#MOVIMENTACAO
		var input_vector = Vector2.ZERO
		
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
			
		
		input_vector = input_vector.normalized()
		
		if is_slow:
			velocity = input_vector * (Globals.speed/2)
		else:
			velocity = input_vector * Globals.speed
			
		move_and_slide()
		
	
		
		if input_vector.length() > 0.1:
			var direction = input_vector.angle()
			rotation = lerp_angle(rotation, direction, Globals.speedRotation * delta)
			
	#ADICIONANDO ANIMAÇAO
			if anim_sprite.animation != "Runinng" and foraDaCasinha:
				anim_sprite.play("Runinng")
		else:
			if foraDaCasinha:
				anim_sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		shop = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Aranhinha":
		shop = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Teia" and teiaReturn:
		area.queue_free()
