extends Area2D
var direction: Vector2 = Vector2.UP
@export var vel: int = 100
@onready var player = get_node("/root/Level/Level1/Player")
signal hit_player

func _ready():
	$AnimationPlayer2.play('bone spin')
func _process(delta):
	position += direction * vel * delta 

func _on_body_entered(body):
	pass
