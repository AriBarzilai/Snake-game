extends TextureButton

# updates button icon to toggled state, to be aligned with muted music
func _ready():
	if Global.soundIsMuted:
		self.set_pressed_no_signal(true)  # (no signal sent because music already muted)
		self.button_pressed = true

func _on_pressed():
	AudioServer.set_bus_mute(AudioServer.get_bus_index(Global.sound), !Global.soundIsMuted)
	Global.soundIsMuted = !Global.soundIsMuted
	Global.updateConfigValue("soundIsMuted", true)
	pass
