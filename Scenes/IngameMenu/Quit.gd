extends Button

func _ready():
	if Global.mobile:
		self.hide()

func _pressed():
	get_tree().quit()
