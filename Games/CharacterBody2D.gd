extends CharacterBody2D
@onready var player = get_node("/root/Level/Level1/Player")
@onready var bones = preload("res://bone.tscn")
var direction : Vector2
var speed : int = 50
var can_shoot = false
signal bone_hit(bone_shot, dire)
func _ready():
	$bonetime.start()
	$bonesss/AnimationPlayer.play('bone walk')
func _physics_process(delta):
	direction = (player.position - position)
	direction = direction.normalized()
	velocity = direction * speed
	move_and_collide(velocity * delta)
	if position.x > player.position.x:
		$bonesss.flip_h = true
	else:
		$bonesss.flip_h = false
	if can_shoot:
		var bones_fire = bones.instantiate()
		var bones_fire2 = bones.instantiate()
		var marker1 = $bonesss/pos/bone_marker
		print(marker1.get_global_position())
		bones_fire.global_position = marker1.position
		bones_fire2.global_position = marker1.position
		var direc = ((player.global_position + Vector2(0,30)) - $bonesss/pos/bone_marker.global_position).normalized()
		bones_fire.rotation_degrees = rad_to_deg(direction.angle())
		bones_fire.direction = direc
		bones_fire2.direction = -direc
		$".".add_child(bones_fire)
		$".".add_child(bones_fire2)
		can_shoot = false
	


func _on_bonetime_timeout():
	print("yih")
	can_shoot = true
	
