extends Label

func _on_h_slider_value_changed(value):
	self.text = str(int(value*100)) + "%"
	pass
