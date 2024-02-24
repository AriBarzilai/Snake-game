extends HSlider

@onready var music = AudioServer.get_bus_index(Global.music)

func _ready():
	if Global.musicIsMuted:
		self.value = 0
	else:
		self.value = Global.musicVolume
	
func _on_value_changed(value):
	AudioServer.set_bus_volume_db(music, linear_to_db(value))
	Global.updateConfigValue("musicVolume", value)
	Global.musicVolume = value
	print("Changed Music Volume to " + str(value*100) + "%")
	pass
