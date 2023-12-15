extends Label


func _on_wraparound_button_toggled(button_pressed):
	self.text = "Enabled" if button_pressed else "Disabled"
	pass 
