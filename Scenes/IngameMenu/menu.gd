extends Control
@onready var title = $Panel/MarginContainer/VBoxContainer/MenuTitle
@onready var playButton = $Panel/MarginContainer/VBoxContainer/Play
@onready var gameSpeed = Global.gameSpeed
signal game_over
var canResumeGame = true # switched to false after game over; user must play again can't continue

func _on_main_game_game_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	print("GAME OVER")
	title.text = "GAME OVER!"
	playButton.text = "Play again"
	playButton.isGameOver = true
	self.show()
	canResumeGame = false
	pass 


func _on_visibility_changed():
	if(self.visible):
		print("Game Paused")
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		print("Game Unpaused")
		Engine.time_scale = gameSpeed
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.
	
func _input(event):
	if(self.visible):
		if event.is_action_pressed("ui_up"):
			if get_viewport().gui_get_focus_owner() == null:
				playButton.grab_focus()
			print("UI SELECT: " + get_viewport().gui_get_focus_owner().get_focus_neighbor(SIDE_TOP).get_name(1))
		elif event.is_action_pressed("ui_down"):
			if get_viewport().gui_get_focus_owner() == null:
				playButton.grab_focus()
			print("UI SELECT: " + get_viewport().gui_get_focus_owner().get_focus_neighbor(SIDE_BOTTOM).get_name(1))

