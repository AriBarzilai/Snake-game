extends Label

@onready var score

func _process(delta):
	self.text = "Score: " + str(Global.score)
	pass
