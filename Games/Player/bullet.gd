extends Area2D
@export var vel: int = 700
var direction: Vector2 = Vector2.UP
signal hit
@export var damage = 50
func _process(delta):
	position += direction * vel * delta

func _on_body_entered(body):
	if body.is_in_group('enemies'):
		Bullet.emit_signal('hit', body)
		queue_free()
	elif body.name == 'TileMap':
		queue_free()

