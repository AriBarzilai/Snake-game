extends Node

### GLOBAL CONSTANTS
var config = ConfigFile.new()
var configPath = "user://settings.cfg"
var loadStatus = config.load(configPath)
# audio bus names
var music = "Music"
var sound = "Sound"

#### GLOBAL SAVED VALUES
var gameSpeed : float = getConfigValue("gameSpeed",1.0)
# determines whether player can collide with game boundaries or loop to the other side 
var wraparound : bool = getConfigValue("wrapAround",false)
var musicVolume : float = getConfigValue("musicVolume", 1)
var musicIsMuted : bool = getConfigValue("musicMute", false)
var soundVolume : float = getConfigValue("soundVolume", 1)
var soundIsMuted : bool = getConfigValue("soundMute", false)

#### GLOBAL UNSAVED VALUES
var score := 0.0
# score which is added each time snake moves a cell. is equal to number of appls eaten
var scoreMultiplier := 0.0


func getConfigValue(key, defaultValue):
	return config.get_value("Settings",key, defaultValue)

func updateConfigValue(key, value):
	Global.config.set_value("Settings", key, value)
	Global.config.save(configPath)

func _ready():
	if loadStatus != OK:
		print(loadStatus)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(musicVolume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(soundVolume))
	AudioServer.set_bus_mute(musicIsMuted, true)
	AudioServer.set_bus_mute(soundIsMuted, true)

	
# resets score to starter values; used when restarting game via Game Over screen
func reset():
	score = 0.0
	scoreMultiplier = 0.0
	


