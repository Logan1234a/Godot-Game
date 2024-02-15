extends CharacterBody2D
signal fire_shot(pos, direction)
signal particle(pos)
var can_shoot: bool = true
var speed: int = 100
var is_moving = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var pos = Input.get_vector("left", "right", "up", "down")
	velocity = pos * speed
	is_moving = true
	if pos.length() == 0:
		$Player_Model/AnimationPlayer.play('idle')
	else:
		$Player_Model/AnimationPlayer.play('walk')
	move_and_slide()
		
	# rotate gun based off of pos
	var gun = $Player_Model/Gun
	var player_m = $Player_Model
	var mouse_position = get_global_mouse_position()
	$Player_Model/Gun.look_at(get_global_mouse_position())
	if mouse_position.x > position.x:
		player_m.flip_h = false
		gun.flip_v = false
	elif mouse_position.x < position.x:
		player_m.flip_h = true
		gun.flip_v = true
		
# fire gun
	if Input.is_action_pressed("fire") and can_shoot:
		var marker = $Player_Model/Gun/bullet_pos/Mark1
		$Player_Model/Gun/bullet_pos/particle.emitting = true
		var bullet_shot = marker
		var particle_affect = marker
		var direction = (get_global_mouse_position() - position).normalized()
		fire_shot.emit(bullet_shot.global_position, direction)
		can_shoot = false
		$FireTIme.start()
		
		
		
# timer for gun
func _on_fire_t_ime_timeout():
	can_shoot = true
