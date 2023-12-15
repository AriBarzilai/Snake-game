extends TextureButton

func _ready():
	self.button_pressed = Global.wraparound

func _on_toggled(button_pressed):
	Global.wraparound = button_pressed
	print("Wraparound set to " + str(button_pressed))
	pass
