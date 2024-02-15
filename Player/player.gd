extends CharacterBody2D
signal fire_shot(pos, direction)
signal particle(pos)
var can_shoot: bool = true
@export var speed: int = 100
var is_moving = false
@export var xp = 0
@export var lvlup = 4
@export var lvl = 0
@export var xp_points = 10
@export var fire_rate = 2.6
@export var lives = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Timer2".wait_time = fire_rate
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if lives <= 0:
		get_tree().change_scene_to_file('res://Level.tscn')
	var pos = Input.get_vector("left", "right", "up", "down")
	velocity = pos * speed
	is_moving = true
	if pos.length() == 0:
		$Player_Model/AnimationPlayer.play('idle')
	else:
		$Player_Model/AnimationPlayer.play('walk')
	move_and_slide()
	$"../Timer2".wait_time = fire_rate
	# rotate gun based off of pos
	var mark = $Player_Model/Gun/bullet_pos/Mark1
	var gun = $Player_Model/Gun
	var player_m = $Player_Model
	var mouse_position = get_global_mouse_position()
	$Player_Model/Gun.look_at(get_global_mouse_position())
	if mouse_position.x > position.x:
		player_m.flip_h = false
		gun.flip_v = false
		$shadow.flip_h = true
	elif mouse_position.x < position.x:
		player_m.flip_h = true
		gun.flip_v = true
		$shadow.flip_h = true
		
# fire gun
	if Input.is_action_pressed("fire") and can_shoot:
		var marker = $Player_Model/Gun/bullet_pos/Mark1
		$Player_Model/Gun/bullet_pos/particle.emitting = true
		var bullet_shot = marker
		var particle_affect = marker
		var spawn_offset = Vector2.ZERO
		marker.global_position += spawn_offset
		var direction = (get_global_mouse_position() - marker.global_position).normalized()
		
		if player_m.flip_h:
			fire_shot.emit(bullet_shot.global_position, direction)
		else:
			fire_shot.emit(bullet_shot.global_position + Vector2(0, 3), direction)
			
		can_shoot = false
		$"../Timer2".start()
		
		
		
		
# timer for gun
func _on_timer_2_timeout():
	can_shoot = true
