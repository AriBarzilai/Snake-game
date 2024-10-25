extends Label

func _ready():
	if Global.mobile:
		self.show()
