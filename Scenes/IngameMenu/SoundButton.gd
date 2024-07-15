extends TextureButton

var sound = AudioServer.get_bus_index("Sound")

# updates button icon to toggled state, to be aligned with muted music
func _ready():
	if(AudioServer.is_bus_mute(sound)):
		self.set_pressed_no_signal(true)  # (no signal sent because music already muted)
		

func _on_pressed():
	AudioServer.set_bus_mute(sound, !AudioServer.is_bus_mute(sound))
	pass
