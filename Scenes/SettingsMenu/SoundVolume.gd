extends HSlider

@onready var sound = AudioServer.get_bus_index("Sound")

func _ready():
	self.value = db_to_linear(AudioServer.get_bus_volume_db(sound))

func _on_value_changed(value):
	AudioServer.set_bus_volume_db(sound, linear_to_db(value))
	print("Changed Sound Volume to " + str(value*100) + "%")
	pass
