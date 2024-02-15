extends Area2D
var direction: Vector2 = Vector2.UP
@export var vel: int = 170
@onready var player = get_node("/root/Level/Level1/Player")
signal boss_hit

func _ready():
	$AnimationPlayer2.play('bone spin')
func _process(delta):
	position += direction * vel * delta 

func _on_body_entered(body):
	if body.name == 'Player':
		player.lives -=1
		print(player.lives)
		queue_free()
	elif body.name == 'TileMap':
		queue_free()
