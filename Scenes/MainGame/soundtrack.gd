extends AudioStreamPlayer

@onready var menu = $"../IngameMenu"
@onready var playbackPosition = 0
@onready var soundtrack = $"."

func _on_menu_visibility_changed():
	if (soundtrack):
		soundtrack.stream_paused = !soundtrack.stream_paused
