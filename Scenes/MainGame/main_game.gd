extends Node

# CONSTANTS
enum Direction {UP, DOWN, LEFT, RIGHT}
@onready var menu = $IngameMenu
@onready var map = $TileMap
signal game_over

# GAME VARIABLES
var deltaCount = 0.0
var applePos = [] # contains the positions of apples on screen
var originalApplePos # the only apple to regenerate another apple

# PLAYER VARIABLES
var snakePos = [] # contains the position of all the cells of the snake; is treated as a queue
var snakeDirection = [] # contains the direction history of the snake which have ALREADY BEEN PLAYED (not incoming directions)
var nextDirections = [] # contains incoming directions which have not yet been played
var canGrow = false # is set to true after snake eats a fruit, and set back to false after snake grows in size

# Called when the node enters the scene tree for the first time.
func _ready():
	initSnake()
	originalApplePos = Vector2i(randi_range(10,19),randi_range(10,19))
	applePos.append(originalApplePos)
	map.set_cell(1,originalApplePos,1,Vector2i.ZERO)
	Engine.time_scale = Global.gameSpeed
	print("Game Start!")
	print("SPAWN APPLE #1: " + str(applePos))
	pass # Replace with function body.


# initializes the snake from (0,0) to (0,3)
func initSnake():
	snakePos.push_front(Vector2i(0,0))
	snakeDirection.push_front(Direction.DOWN)
	map.set_cell(1,Vector2i(0,0),0,Vector2i(0,1))
	
	snakePos.push_front(Vector2i(0,1))
	snakeDirection.push_front(Direction.DOWN)
	map.set_cell(1,Vector2i(0,1),0,Vector2i(4,1))
	
	snakePos.push_front(Vector2i(0,2))
	snakeDirection.push_front(Direction.DOWN)
	map.set_cell(1,Vector2i(0,2),0,Vector2i(4,1))

	snakePos.push_front(Vector2i(0,3))
	snakeDirection.push_front(Direction.DOWN)
	map.set_cell(1,Vector2i(0,3),0,Vector2i(3,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(deltaCount > 0.06):
		moveSnake()
		Global.score += Global.scoreMultiplier
		deltaCount = 0.0
	deltaCount += delta
	pass

func _input(event):
	if event.is_action_pressed("ui_pause") && menu.get("canResumeGame"):
		if(menu.visible):
			menu.hide()
		else:
			menu.show()
			
	if (!menu.visible):
		# cheat mode:
		#if event.is_action_pressed("ui_godmode"):
		#	var apples_to_generate = (400 - len(snakeDirection))/6
		#	for i in range(apples_to_generate):
		#		generateApple(true)
		if event.is_action_pressed("ui_up"):
			addDirection(Direction.UP)
		if event.is_action_pressed("ui_down"):
			addDirection(Direction.DOWN)
		if event.is_action_pressed("ui_left"):
			addDirection(Direction.LEFT)
		if event.is_action_pressed("ui_right"):
			addDirection(Direction.RIGHT)

# helper function for _input.
# adds a new direction to the queue, which will be eventually played in a process() function call
# if not overwritten by more inputs
func addDirection(direction):
	if (nextDirections.size() && nextDirections.front() == direction): # prevents duplicate presses flooding the array and overwriting other key presses
		return
	nextDirections.push_front(direction)
	if len(nextDirections) > 3:
		nextDirections.pop_back()
		
func generateApple(isDuplicate):
	var newPos = Vector2i(randi_range(0,19),randi_range(0,19))
	while (snakePos.has(newPos) || applePos.has(newPos)):
		newPos = Vector2i(randi_range(0,19),randi_range(0,19))
	applePos.append(newPos)
	if isDuplicate:
		map.set_cell(1,newPos,3,Vector2i.ZERO)
	else:
		map.set_cell(1,newPos,1,Vector2i.ZERO)
		originalApplePos = newPos
	print("SPAWN APPLE #" + str(Global.scoreMultiplier+1) + ": " + str(newPos))
		
# Moves the snake according to the current direction
func moveSnake():
	var headPos = snakePos.front()
	var tailPos
	var newPos
	var nextDirection = nextDirections.pop_back()
	
	if (nextDirection == null):
		nextDirection = snakeDirection.front()
		
	# UPDATE SNAKE HEAD POSITION
	# in case of "illegal move" (e.g inputting up direction while moving down),
	# incoming direction is overwritten to current direction
	var tempArr = updateSnakeHeadPos(nextDirection, headPos)
	nextDirection = tempArr[0]
	newPos = tempArr[1]
	
	# UPDATE POSITION IN CASE OF WRAPAROUND		
	if(Global.wraparound):
		if (newPos.x > 19):
			newPos.x = 0
		if(newPos.x < 0):
			newPos.x = 19
		if (newPos.y > 19):
			newPos.y = 0
		if (newPos.y < 0):
			newPos.y = 19
	elif(newPos.x > 19 || newPos.x < 0 || newPos.y > 19 || newPos.y < 0):
		$hitWallNoise.play()
		emit_signal("game_over")
	
	match nextDirection:
		Direction.DOWN:
			map.set_cell(1,newPos,0,Vector2i(3,0))
		Direction.UP:
			map.set_cell(1,newPos,0,Vector2i(2,1))
		Direction.LEFT:
			map.set_cell(1,newPos,0,Vector2i(3,1))
		Direction.RIGHT:
			map.set_cell(1,newPos,0,Vector2i(2,0))
	var apple_index = applePos.find(newPos)		
	if (apple_index != -1): # if snake has eaten an apple
		canGrow = true
		Global.score += 50
		Global.scoreMultiplier += 1
		$eatAppleNoise.play()
		if (applePos[apple_index] == originalApplePos):
			generateApple(false)
		applePos.remove_at(apple_index)
	
	# UPDATE OLD HEAD POSITION (replace with body cell)
	# takes into account corner cells
	match snakeDirection.front():
		Direction.DOWN:
			match nextDirection:
				Direction.DOWN:
					map.set_cell(1, headPos, 0, Vector2i(4,1))
				Direction.LEFT:
					map.set_cell(1, headPos, 0, Vector2i(6,1))
				Direction.RIGHT:
					map.set_cell(1, headPos, 0, Vector2i(5,1))
		Direction.UP:
			match nextDirection:
				Direction.UP:
					map.set_cell(1, headPos, 0, Vector2i(4,1))
				Direction.LEFT:
					map.set_cell(1, headPos, 0, Vector2i(6,0))
				Direction.RIGHT:
					map.set_cell(1, headPos, 0, Vector2i(5,0))
		Direction.LEFT:
			match nextDirection:
				Direction.LEFT:
					map.set_cell(1, headPos, 0, Vector2i(4,0))
				Direction.UP:
					map.set_cell(1, headPos, 0, Vector2i(5,1))
				Direction.DOWN:
					map.set_cell(1, headPos, 0, Vector2i(5,0))
		Direction.RIGHT:
			match nextDirection:
				Direction.RIGHT:
					map.set_cell(1, headPos, 0, Vector2i(4,0))
				Direction.UP:
					map.set_cell(1, headPos, 0, Vector2i(6,1))
				Direction.DOWN:
					map.set_cell(1, headPos, 0, Vector2i(6,0))
					
	# if the new position already exists in the queue of snake positions, end game because self collision
	if snakePos.has(newPos): 
		$hitSelfNoise.play()
		emit_signal("game_over")
		return 
		
	if (canGrow):
		canGrow = !canGrow
	else:
		snakeDirection.pop_back() # remove old tail from map (snake has moved from position)
		map.set_cell(1,snakePos.pop_back(),-1)
		# Update current tail direction to follow the snake body (in case of snake turning - thus update with whoever is before it
		snakeDirection.pop_back()
		snakeDirection.push_back(snakeDirection.back())

	# UPDATE TAIL POSITION
	tailPos = snakePos.back()
	match snakeDirection.back():
		Direction.RIGHT:
			map.set_cell(1,tailPos,0,Vector2i(0,0))
		Direction.LEFT:
			map.set_cell(1,tailPos,0,Vector2i(1,0))
		Direction.DOWN:
			map.set_cell(1,tailPos,0,Vector2i(0,1))
		Direction.UP:
			map.set_cell(1,tailPos,0,Vector2i(1,1))
	snakePos.push_front(newPos)
	snakeDirection.push_front(nextDirection)
	
	
# this function handles snake head placement logic.
# if player presses button in opposite direction of where snake is headed, it ignores keystroke,
# and instead moves player in current direction
func updateSnakeHeadPos(nextDirection, headPos):
	var newPos
	match nextDirection:
		Direction.DOWN:
			if (snakeDirection.front() == Direction.UP):
				return updateSnakeHeadPos(Direction.UP, headPos)
			newPos = Vector2i(headPos.x, headPos.y+1)
			map.set_cell(1,newPos,0,Vector2i(3,0))
		Direction.UP:
			if (snakeDirection.front() == Direction.DOWN):
				return updateSnakeHeadPos(Direction.DOWN, headPos)
			newPos = Vector2i(headPos.x, headPos.y-1)
			map.set_cell(1,newPos,0,Vector2i(2,1))
		Direction.LEFT:
			if (snakeDirection.front() == Direction.RIGHT):
				return updateSnakeHeadPos(Direction.RIGHT, headPos)
			newPos = Vector2i(headPos.x-1, headPos.y)
			map.set_cell(1,newPos,0,Vector2i(3,1))
		Direction.RIGHT:
			if (snakeDirection.front() == Direction.LEFT):
				return updateSnakeHeadPos(Direction.LEFT, headPos)
			newPos = Vector2i(headPos.x+1, headPos.y)
			map.set_cell(1,newPos,0,Vector2i(2,0))
	return [nextDirection, newPos]
