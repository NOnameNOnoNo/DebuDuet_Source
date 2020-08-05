extends ColorRect

var player
var timer
export var fadeoutscene = "title"

func _ready():
	player = $player
	timer = $switchtimer

func _fadeout():
	player.play("fadeout")
	timer.start()

func _sceneswitch():
	var path = "title"
	if fadeoutscene == "title":
		path = "res://assets/scenes/title.tscn"
	if fadeoutscene == "game":
		path = "res://assets/scenes/game.tscn"
	get_tree().change_scene(path)
