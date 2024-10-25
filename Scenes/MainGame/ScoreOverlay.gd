extends Label

@onready var score

func _process(_delta):
	self.text = "Score: " + str(Global.score)
	pass
