extends Node2D

@onready var animation = $AnimationPlayer

func _ready():
	animation.play("fade_in")
	await get_tree().create_timer(3.5).timeout
	animation.play("fade_out")
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file('res://Scenes/MainMenu/main_menu.tscn')
	pass 
