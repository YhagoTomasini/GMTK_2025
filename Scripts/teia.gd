extends Area2D

var maxSpeed : float = 300
var speed : float
var deceleration : float = 180
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = maxSpeed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if speed > 0:
		position.y += 20 * delta
		position += Vector2.RIGHT.rotated(rotation) * speed * delta
		speed = max(speed - deceleration * delta, 0)
	else:
		deterioramento()
func deterioramento():
	await get_tree().create_timer(1).timeout
	queue_free()
