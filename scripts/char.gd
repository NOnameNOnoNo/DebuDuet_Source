extends Node2D

#you can drag and drop any amount of texture files in this array
export(Array) var textures
#character sprite
var sprite
#an animation player
var player
#state machine
var smachine
#weight gain stage
var stage = 0.0
#score
var score = 0.0
#score multiplier
export var mlp = 1.0
#signal for stats displays
signal stats
#side indicator
export var side = "left"
#NPC indicator
export var bot = false
#victory SFX
var win
#failure SFX
var fail
#audio player
var audplayer

func _ready():
	#get the nodes
	sprite = $sprite
	player = $animplayer
	smachine = $animtree.get("parameters/playback")
	win = preload("res://assets/sound/win.wav")
	fail = preload("res://assets/sound/fail.wav")
	audplayer = $winlose
	#call this function to set the first sprite
	_spriteswap()

func _spriteswap():
	#as long as there are enough textures, swap sprites based on the WG stage and update the value afterwards
	if int(stage) < textures.size():
		sprite.texture = textures[int(stage)]
		#play transition animation
		smachine.travel("swap")
		stage += 1.0

#this function increases the multiplier and score if the side matches
func _mlpinc(var bonus, var charside):
	if side == charside:
		if bot == false:
			mlp += bonus / 2.0
		score += 10.0 * mlp
		#play eating animation
		smachine.travel("fed")
		emit_signal("stats", score, mlp, stage)
		#change sprite every '100 * stage * stage' points
		if floor(score / 100.0) * 100.0 > 100.0 * stage * stage:
			_spriteswap()

#rewards NPC with points and multiplier increase
func _mistake():
	if bot == true:
		mlp += 1.0
		score += 10.0 * mlp
		smachine.travel("fed")
		emit_signal("stats", score, mlp, stage)
		#change sprite every '100 * stage * stage' points
		if floor(score / 100.0) * 100.0 > 100.0 * stage * stage:
			_spriteswap()

func _youwon():
	if bot == false:
		audplayer.stream = win
	else:
		audplayer.stream = fail
	audplayer.play()
