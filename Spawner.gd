extends Node2D

@export var max_enemies = 10
var wave = 6
var enemy_spawner := preload("res://Enemy/enemy_1.tscn")
var boss1 := preload("res://Boss1.tscn")

var spawn_timer := 3
var spawn_points := []
var spawned = 0

func _ready():
	$"../Timer".wait_time = spawn_timer
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)	

func _on_timer_timeout():
	var enemies = get_tree().get_nodes_in_group('enemies')
	var boss_first = get_tree().get_nodes_in_group('bosses')
	if wave == 1:
		max_enemies = 5
		if enemies.size() < max_enemies:
			if spawned <= max_enemies:
				var spawn = spawn_points[randi() % spawn_points.size()]
				spawned +=1
				var skeli = enemy_spawner.instantiate()
				skeli.position = spawn.position
				skeli.speed = 10 + randi_range(0,11)
				$".".add_child(skeli)
				skeli.add_to_group('enemies')
			if spawned >= max_enemies and enemies.size() == 0:
				wave = 2
				spawned = 0
	if wave == 2:
		spawn_timer = 2
		$"../Timer".wait_time = spawn_timer
		max_enemies = 10
		if enemies.size() < max_enemies:
			if spawned <= max_enemies:
				var spawn = spawn_points[randi() % spawn_points.size()]
				spawned +=1
				var skeli = enemy_spawner.instantiate()
				skeli.position = spawn.position
				skeli.speed = 10 + randi_range(20,31)
				$".".add_child(skeli)
				skeli.add_to_group('enemies')
			if spawned >= max_enemies and enemies.size() == 0:
				wave = 3
				spawned = 0
	if wave == 3:
		spawn_timer = 1
		$"../Timer".wait_time = spawn_timer
		max_enemies = 15
		if enemies.size() < max_enemies:
			if spawned <= max_enemies:
				var spawn = spawn_points[randi() % spawn_points.size()]
				spawned +=1
				var skeli = enemy_spawner.instantiate()
				skeli.position = spawn.position
				skeli.speed = 10 + randi_range(30,51)
				$".".add_child(skeli)
				skeli.add_to_group('enemies')
			if spawned >= max_enemies and enemies.size() == 0:
				wave = 4
				spawned = 0
	if wave == 4:
		spawn_timer = 0.5
		$"../Timer".wait_time = spawn_timer
		max_enemies = 20
		if enemies.size() < max_enemies:
			if spawned <= max_enemies:
				var spawn = spawn_points[randi() % spawn_points.size()]
				spawned +=1
				var skeli = enemy_spawner.instantiate()
				skeli.position = spawn.position
				skeli.speed = 10 + randi_range(30,61)
				$".".add_child(skeli)
				skeli.add_to_group('enemies')
			if spawned >= max_enemies and enemies.size() == 0:
				wave = 5
				spawned = 0
	if wave == 5:
		spawn_timer = 0.2
		$"../Timer".wait_time = spawn_timer
		max_enemies = 30
		if enemies.size() < max_enemies:
			if spawned <= max_enemies:
				var spawn = spawn_points[randi() % spawn_points.size()]
				spawned +=1
				var skeli = enemy_spawner.instantiate()
				skeli.position = spawn.position
				skeli.speed = 10 + randi_range(40,71)
				$".".add_child(skeli)
				skeli.add_to_group('enemies')
			if spawned >= max_enemies and enemies.size() == 0:
				wave = 6
				spawned = 0
	if wave == 6:
		spawn_timer = 0.1
		$"../Timer".wait_time = spawn_timer
		max_enemies = 1
		if boss_first.size() < max_enemies:
			if spawned <= max_enemies:
				var spawn = $boss_spawn
				spawned +=1
				var boss = boss1.instantiate()
				boss.position = spawn.position
				$".".add_child(boss)
				boss.add_to_group('bosses')
			if spawned >= max_enemies and boss_first.size() == 0:
				wave = 0
				spawned = 0
	if wave == 0:
		pass
		
	
	
