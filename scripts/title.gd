extends Control

var saver
var player
var side = "left"
var pressed = false
var fader

# Called when the node enters the scene tree for the first time.
func _ready():
	saver = $saver
	player = $animplayer
	fader = $fader

func _process(delta):
	if pressed == false:
		if Input.is_action_just_pressed("ui_left"):
			side = "left"
			pressed = true
			_select(side)
		if Input.is_action_just_pressed("ui_right"):
			side = "right"
			pressed = true
			_select(side)

func _select(var charside):
	if side == "left":
		player.play("choiceleft")
		fader._fadeout()
	if side == "right":
		player.play("choiceright")
		fader._fadeout()
	saver._savechoice(charside)
