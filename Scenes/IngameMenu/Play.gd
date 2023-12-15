extends Button

@onready var menu = $"../../../.."
var isGameOver = false

# upon pressing, unpauses the game. if game is over, unpauses + restarts game
func _pressed():
	if(isGameOver):
		get_tree().reload_current_scene()
		Global.reset()
	menu.hide()
