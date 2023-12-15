extends Button

@onready var menu = $"../../../.."
@onready var global = Global
var isGameOver = false

# upon pressing, unpauses the game. if game is over, unpauses + restarts game
func _pressed():
	if(isGameOver):
		get_tree().reload_current_scene()
		global.reset()
	menu.hide()
