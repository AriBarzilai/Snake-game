extends TextureButton

# updates button icon to toggled state, to be aligned with muted music
func _ready():
	if Global.musicIsMuted:
		self.set_pressed_no_signal(true)  # (no signal sent because music already muted)
		self.button_pressed = true
		

func _on_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index(Global.music), !Global.musicIsMuted)
	Global.musicIsMuted = !Global.musicIsMuted
	Global.updateConfigValue("musicIsMuted", true)
	pass
