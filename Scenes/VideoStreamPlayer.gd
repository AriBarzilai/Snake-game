extends Control

@onready var video = $"."

func _ready():
	pass
	

func _on_finished():
	video.play()
	pass # Replace with function body.
