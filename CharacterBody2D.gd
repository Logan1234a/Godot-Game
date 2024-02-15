extends CharacterBody2D
@onready var player = get_node("/root/Level/Level1/Player")
@onready var bones = preload("res://bone.tscn")
var direction : Vector2
var speed : int = 50
var can_shoot = false
var damage = 0
var health = 10000
signal health_change
var alive = true
signal bone_hit(bone_shot, dire)
func _ready():
	$bonetime.start()
	$bonesss/AnimationPlayer.play('bone walk')
	Bullet.boss_hit.connect(self._hit_by_bullet)
	
func _physics_process(delta):
	if player.lives == 0:
		queue_free()
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
		var bones_fire3 = bones.instantiate()
		var marker1 = $bonesss/pos/bone_marker
		bones_fire.global_position = marker1.position
		bones_fire2.global_position = marker1.position
		bones_fire3.global_position = marker1.position
		var direc = ((player.global_position + Vector2(0,30)) - $bonesss/pos/bone_marker.global_position).normalized()
		var direc2 = (Vector2(500, 0) - $bonesss/pos/bone_marker.global_position).normalized()
		bones_fire.rotation_degrees = rad_to_deg(direction.angle())
		bones_fire.direction = direc
		bones_fire2.direction = -direc
		bones_fire3.direction = direc2
		$".".add_child(bones_fire)
		$".".add_child(bones_fire2)
		$".".add_child(bones_fire3)
		can_shoot = false
	


func _hit_by_bullet(body):
	damage = Bullet.damage
	emit_signal("health_change")
	health -= damage
	if damage >= health:
		if alive:
			alive = false
		speed = 0
		$bonesss/AnimationPlayer.play('dead')
		$bone_colide.set_deferred('disabled', true)
		damage = 0
	else:
		$bonesss/AnimationPlayer.play('hit')

func _on_bonetime_timeout():
	can_shoot = true
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'hit':
		$bonesss/AnimationPlayer.play('bone walk')
	if anim_name == 'dead':
		queue_free()
