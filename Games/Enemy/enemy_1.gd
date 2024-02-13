extends CharacterBody2D

@onready var player = get_node("/root/Level/Level1/Player")
@onready var spawner = get_node("/root/Level/Level1/Spawner")
var bullet_scene
@export var speed : int = 20
var direction : Vector2
var health = 100
var damage = 0
var xp = 1
var alive = true
var touching = false
signal enemy_freed(pos, direction)

func _ready():
	$AnimationPlayer.play('walk')
	Bullet.hit.connect(self.hit_player)
	
func _process(_delta):
	if spawner.wave >= 2 and spawner.wave < 3:
		xp = 3
	elif spawner.wave > 3:
		xp = 4
	if spawner.wave >= 4:
		health = 150
		
func hit_player(enemy):
	if self == enemy:
		damage += Bullet.damage
		if damage >= health:
			if alive:
				alive = false
			$AnimationPlayer.play('dead')
			$CollisionShape2D.set_deferred('disabled', true)
			damage = 0
		else:
			$AnimationPlayer.play('hit')
			
func _physics_process(delta):
	direction = (player.position - position)
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	if position.x > player.position.x:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "swing":
		if alive:
			$AnimationPlayer.play("swing")
		player.lives -= 1
		if player.lives <= 0:
			player.get_tree().change_scene_to_file('res://Level.tscn')
		print(player.lives)
	if anim_name == "hit":
		if alive:
			$AnimationPlayer.play('walk')
	if anim_name == 'dead':
		emit_signal("enemy_freed")
		queue_free()
		player.xp += xp
		if player.xp >= player.lvlup:
			player.xp_points += 1
			player.lvl += 1
			player.xp = 0
			player.lvlup *= 2
		print(player.xp)
		print(player.lvl)
		print(player.lvlup)
		print(player.xp_points)
		
	

func _on_area_2d_body_entered(body):
	if alive:
		$AnimationPlayer.play('swing')


func _on_area_2d_body_exited(body):
	if alive:
		$AnimationPlayer.play('walk')
	if body.is_in_group('enemies'):
		touching = false
