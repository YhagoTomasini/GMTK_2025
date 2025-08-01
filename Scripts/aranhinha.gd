extends CharacterBody2D

const sceneTeia = preload("res://Prefarbs/teia.tscn")
@onready var cam: Camera2D = $"../Camera2D"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collisionArana: CollisionShape2D = $CollisionArana
@onready var collisionArea: CollisionShape2D = $Area2D/CollisionShape2D

@onready var anim_sprite: AnimatedSprite2D = $animSprite

@onready var teste_de_chuva: Node2D = $"../Camera2D/TesteDeChuva"

#UI
@onready var visual_cd_teia: Sprite2D = $"../HUD/Control/TeiasCounter/VisualCDTeia"
@onready var visual_cd_casulo: Sprite2D = $"../HUD/Control/CasulosCounter/VisualCDCasulo"
#textos
@onready var text_berries: Label = $"../HUD/Control/BerriesCounter/TextBerries"
@onready var text_casulos: Label = $"../HUD/Control/CasulosCounter/TextCasulos"
@onready var text_teias: Label = $"../HUD/Control/TeiasCounter/TextTeias"

#VARIAVEIS
var cdTimeTeia : float = 0
var cdTimeCasulo : float = 0

#BOOLEANAS
var shop : bool
var vaiTeia : bool
var comCasulo : bool
var foraDaCasinha : bool
var teiaReturn : bool
var inicio : bool
var aQueda : bool

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
	inicio = true
	aQueda = false
	
	collisionArana.disabled = false
	collisionArea.disabled = false
	
	visual_cd_casulo.modulate = Color(1, 1, 1, 0)
	visual_cd_teia.modulate = Color(1, 1, 1, 0)
	
func chuva_a_derrubou():
	print("CHUVAAAAAAAAAAAAAAAA")
	var posicaoAtual : float = position.y
	#collisionArana.disabled = true
	#collisionArea.disabled = true
	collisionArana.set_deferred("disabled", true)
	collisionArea.set_deferred("disabled", true)
	foraDaCasinha = false
	
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position:y", 636.0, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(self, "rotation", rotation + TAU * 2, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	aQueda = true
	
	await tween.finished
	
	get_tree().reload_current_scene()
	

func podeTeia():
	visual_cd_teia.modulate = Color(1, 0.5, 0.5, 0.5)
	
	await get_tree().create_timer(Globals.cdTeia).timeout
	visual_cd_teia.modulate = Color(1, 1, 1, 0)
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
	visual_cd_casulo.modulate = Color(1, 1, 1, 0)
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
	if position.y <= cam.position.y and !aQueda:
		cam.position.y = position.y
	
	if aQueda:
		cam.position.y = position.y
	
	#ATUALIZACAO do TEXTO das BERRIES
	text_berries.text = str(Globals.berries)
	
	#COOLDOWN TEIA
	if !vaiTeia:
		cdTimeTeia += delta
		var t = clamp(cdTimeTeia / Globals.cdTeia, 0, 1)
		visual_cd_teia.scale.y = lerp(40.0, 0.0, t)
	else:
			cdTimeTeia = 0
			visual_cd_teia.scale.y = 40
	
	if vaiTeia and Globals.teias == 0:
		podeTeia()
		vaiTeia = false
	
	#COOLDOWN CASULO
	if !comCasulo:
		cdTimeCasulo += delta
		var t = clamp(cdTimeCasulo / Globals.cdCasulo, 0, 1)
		visual_cd_casulo.scale.y = lerp(40.0, 0.0, t)
	else:
		cdTimeCasulo = 0
		visual_cd_casulo.scale.y = 40
		
	if comCasulo and Globals.casulos == 0:
		generateCasulo()
		comCasulo = false
		
	#SE N ESTIVER NO CASULO
	if foraDaCasinha:
		
	#TEIA
		if vaiTeia and Input.is_action_just_pressed("ui_accept") and !shop and !inicio:
			cuspir()
		
	#CASULO
		if comCasulo and Input.is_action_just_pressed("ui_cancel") and Globals.casulos >= 1 and !inicio:
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
		
		#GOMA
		if is_slow:
			velocity = input_vector * (Globals.speed/4)
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

#COLISAO SHOPPING
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		shop = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Aranhinha":
		shop = false

#MATAR TEIA
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		if teiaReturn:
			area.queue_free()
		else:
			await get_tree().create_timer(0.6).timeout
			if area != null:
				area.queue_free()

#COLISAO INICIO
func _on_inicio_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		inicio = true

func _on_inicio_body_exited(body: Node2D) -> void:
	if body.name == "Aranhinha":
		inicio = false
		teste_de_chuva.spawn_da_chuva()

#COLISAO FIM
func _on_area_fim_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		get_tree().change_scene_to_file("res://Scene/tela_final.tscn")
