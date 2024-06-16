extends Control

# used to return to splash screen for the purpose of recording the trailer
func _input(event):
	if event.is_action("ui_reload_game"):
		get_tree().change_scene_to_file('res://Scenes/SplashScreen/splash_screen.tscn')
	if event.is_action_pressed("ui_up"):
		if get_viewport().gui_get_focus_owner() == null:
			$MarginContainer/Panel/VBoxContainer/SettingsButton.grab_focus()
		print("UI SELECT: " + get_viewport().gui_get_focus_owner().get_focus_neighbor(SIDE_TOP).get_name(1))
	elif event.is_action_pressed("ui_down"):
		if get_viewport().gui_get_focus_owner() == null:
			$MarginContainer/Panel/VBoxContainer/SettingsButton.grab_focus()
		print("UI SELECT: " + get_viewport().gui_get_focus_owner().get_focus_neighbor(SIDE_BOTTOM).get_name(1))
		
