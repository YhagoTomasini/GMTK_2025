extends Area2D

var capturado : bool = false

var posiTeia : Area2D

@onready var anim_sprite: AnimatedSprite2D = $anim_sprite
var escolha_da_frutinha : int 

@onready var berry_pop: AudioStreamPlayer2D = $berryPop

func _ready() -> void:
	var rot = randi_range(0,1)
	if rot == 0:
		pass
	elif  rot == 1:
		anim_sprite.scale.x *= -1
	
	escolha_da_frutinha = randi_range(1,4)
	if escolha_da_frutinha == 1:
		anim_sprite.play("acerola")
	elif escolha_da_frutinha == 2:
		anim_sprite.play("amora")
	elif escolha_da_frutinha == 3:
		anim_sprite.play("framboesa")
	elif escolha_da_frutinha == 4:
		anim_sprite.play("mirtilo")
		
func _physics_process(_delta: float) -> void:
	if capturado:
		if posiTeia != null:
			position = posiTeia.global_position
		

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		capturado = true
		area.coletar = true
		posiTeia = area

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Aranhinha":
		body.berryPop()
		berry_pop.play()
		Globals.berries += 1
		queue_free()
