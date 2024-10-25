extends Node

#### GLOBAL SAVED VALUES
var gameSpeed := 0.7
# determines whether player can collide with game boundaries or loop to the other side 
var wraparound := true

#### GLOBAL UNSAVED VALUES
var score := 0.0
# score which is added each time snake moves a cell. is equal to number of appls eaten
var scoreMultiplier := 0.0

# resets score to starter values; used when restarting game via Game Over screen
func reset():
	score = 0.0
	scoreMultiplier = 0.0

var mobile := true	
func _ready():
	mobile = (OS.has_feature("web_android") or OS.has_feature("web_ios"))

