extends Button



func _on_pressed():
	Global.reset()
	get_tree().change_scene_to_file('res://Scenes/MainGame/main_game.tscn')
	pass

