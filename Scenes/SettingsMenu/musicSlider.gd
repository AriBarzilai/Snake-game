extends HSlider

@onready var music = AudioServer.get_bus_index("Music")

func _ready():
	self.value = db_to_linear(AudioServer.get_bus_volume_db(music))
	
func _on_value_changed(value):
	AudioServer.set_bus_volume_db(music, linear_to_db(value))
	print("Changed Music Volume to " + str(value*100) + "%")
	pass
