extends Button

func _ready():
	if Global.mobile:
		self.hide()

func _on_pressed():
	get_tree().quit()
