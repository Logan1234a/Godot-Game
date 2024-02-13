extends Control

@export var game_manager : Game_Pause
@onready var player = get_node("/root/Level/Level1/Player")
var times = 0
var times_2 = 0
var times_3 = 0
func _ready():
	hide()
	game_manager.toggle_pause.connect(_pause)

func _pause(is_pause : bool):
	if is_pause:
		show()
	else:
		hide()
	
func _process(_delta):
	$"Panel/Xp Label".set_text(str(player.xp_points))
	$Panel/Fire_Rate.set_text(str(times))
	$Panel/MovementSpeed.set_text(str(times_2))
	if Bullet.damage == 300:
		times_3 = 'MAX'
	$Panel/Damage.set_text(str(times_3))
	
	
func _on_fire_rate_pressed():
	var exp = player.xp_points 
	if exp > 0 and player.fire_rate > 0.2:
		player.fire_rate -= 0.6
		player.xp_points -=1
		times +=1
	elif exp > 0 and player.fire_rate > 0.1:
		player.fire_rate -= 0.1
		player.xp_points -=1
		times = 'MAX'
	elif player.fire_rate <= 0.1:
		print("Max Level")
	if exp <= 0:
		print("Used all xp points")
		


func _on_move_speed_pressed():
	var exp = player.xp_points
	if exp > 0 and player.speed < 200:
		player.speed += 25
		player.xp_points -=1
		times_2 += 1
	elif player.speed >= 200:
		times_2 = "MAX"
		print(player.speed)
		print("Max level")
	if exp <= 0:
		print("Used all xp points")


func _on_damage_pressed():
	var exp = player.xp_points 
	if exp > 0 and Bullet.damage < 300:
		Bullet.damage += 50
		player.xp_points -=1
		times_3 += 1
		print(Bullet.damage)
	if exp <= 0:
		print("Used all xp points")
