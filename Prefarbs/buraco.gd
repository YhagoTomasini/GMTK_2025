extends Node2D

@onready var collision: StaticBody2D = $StaticBody2D

@onready var sprite_teia_path: Sprite2D = $SpriteTeiaPath



func _ready() -> void:
	sprite_teia_path.visible = false

func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Teia":
		collision.queue_free()
		sprite_teia_path.visible = true
		
