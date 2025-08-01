extends Area2D

var aranha: CharacterBody2D
var posiAranha : Vector2

var coletar : bool = false

var speed : float
var deceleration : float = 180
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = Globals.teiaForce

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	posiAranha = aranha.position
	
	if !coletar:
		if speed > 0:
			position.y += 25 * delta
			position += Vector2.RIGHT.rotated(rotation) * speed * delta
			speed = max(speed - deceleration * delta, 0)
		else:
			deterioramento()
	
	else:
		position = lerp(position, posiAranha, (Globals.speed*0.08) * delta)
		
		
func deterioramento():
	await get_tree().create_timer(1).timeout
	queue_free()
	
