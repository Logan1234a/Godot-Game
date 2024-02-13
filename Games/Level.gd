extends Node

class_name Game_Pause

signal toggle_pause(is_pause: bool)
func _ready():
	pass
	
var game_pause : bool = false:
	get:
		return game_pause
	set(value):
		game_pause = value
		get_tree().paused = game_pause
		emit_signal('toggle_pause', game_pause)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		game_pause = !game_pause
		
