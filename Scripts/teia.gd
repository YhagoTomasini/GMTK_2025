extends Area2D

var aranha: CharacterBody2D
var posiAranha : Vector2

var coletar : bool = false

var maxSpeed : float = 300
var speed : float
var deceleration : float = 180
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = maxSpeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	posiAranha = aranha.position
	
	if !coletar:
		if speed > 0:
			position.y += 20 * delta
			position += Vector2.RIGHT.rotated(rotation) * speed * delta
			speed = max(speed - deceleration * delta, 0)
		else:
			deterioramento()
	
	else:
		position = lerp(position, posiAranha, 4 * delta)
		
		
func deterioramento():
	await get_tree().create_timer(1).timeout
	queue_free()	
	
