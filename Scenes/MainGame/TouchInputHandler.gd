extends TouchScreenButton

class_name SwipeScreenButton

var is_swiping := false
var swipe_margin := 4
var keyPress := InputEventAction.new()



func _ready():
	self.connect("pressed", Callable(self, "_on_self_pressed"))
	self.connect("released", Callable(self, "_on_self_released"))
	keyPress.pressed = true


func _input(event):
	if not Global.mobile:
		return
	if not (event is InputEventScreenDrag):
		return
	
	var swipe = event.relative	
	
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y >= swipe_margin:
		keyPress.action = "ui_down"
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y <= -swipe_margin:
		keyPress.action = "ui_up"
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x >= swipe_margin:
		keyPress.action = "ui_right"
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x <= -swipe_margin:
		keyPress.action = "ui_left"
	
	if is_swiping == true:
		Input.parse_input_event(keyPress)

	# Example of getting down left angle swipe
#	elif swipe.x >= -swipe_margin and swipe.y >= swipe_margin:
#		swipe_direction = Vector2(-1,1)


func _on_self_pressed():
	is_swiping = true


func _on_self_released():
	is_swiping = false
