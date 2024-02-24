extends HSlider

@onready var sound = AudioServer.get_bus_index(Global.sound)

func _ready():
	if Global.soundIsMuted:
		self.value = 0
	else:
		self.value = Global.soundVolume

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(sound, linear_to_db(value))
	Global.updateConfigValue("soundVolume", value)
	Global.soundVolume = value
	print("Changed Sound Volume to " + str(value*100) + "%")
	pass
