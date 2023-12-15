extends Control

# used to return to splash screen for the purpose of recording the trailer
func _input(event):
	if event.is_action("ui_reload_game"):
		get_tree().change_scene_to_file('res://Scenes/SplashScreen/splash_screen.tscn')
