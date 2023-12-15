extends HSlider

func _ready():
	self.value = Global.gameSpeed

func _on_value_changed(value):
	Global.gameSpeed = value
	print("Changed Game Speed to " + str(value))
	pass
