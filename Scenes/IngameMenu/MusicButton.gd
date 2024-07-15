extends TextureButton

var music = AudioServer.get_bus_index("Music")

# updates button icon to toggled state, to be aligned with muted music
func _ready():
	if(AudioServer.is_bus_mute(music)):
		self.set_pressed_no_signal(true)  # (no signal sent because music already muted)
		

func _on_pressed():
	AudioServer.set_bus_mute(music, !AudioServer.is_bus_mute(music))
	pass
