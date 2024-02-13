extends Node2D

var bullet = preload("res://Player/bullet.tscn")
# Called when the node enters the scene tree for the first time.


func _on_area_2d_body_entered(_body):
	print("entered")


func _on_player_fire_shot(pos, direction):
	var bullet_fire = bullet.instantiate()
	bullet_fire.position = pos 
	bullet_fire.rotation_degrees = rad_to_deg(direction.angle())
	bullet_fire.direction = direction
	$Projectiles.add_child(bullet_fire)



