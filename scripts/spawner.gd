extends Node2D

#array of food item scenes, make sure to assign groups 'food_l' or 'food_r' when adding new types of food
export(Array) var food
#arrows
var arrow_l
var arrow_r
#animation player
var animplayer
#node to hold and animate food
var foodholder
#node for the food itself
var newfood
#timer
var timer
#size modifiers for the arrows
var size_l = 1.0
var size_r = 1.0
#variable to prevent multiple inputs
var pressed = false
#relative time value
var timerel = 0.0
#signal to increase your multiplier
signal bonus
#signal to increase opponent's multiplier
signal mistake
export var enemy = "right"
#signal for parent node to get results
signal results
#particle effect
var fx
#crunch SFX player
var crunch
#mistake SFX player
var wrong

func _ready():
	randomize()
	#get the nodes
	arrow_l = $arrow_l
	arrow_r = $arrow_r
	animplayer = $animplayer
	foodholder = $foodholder
	fx = $fx
	crunch = $crunch
	wrong = $wrong
	timer = $timer
	timer.start()
	_spawnfood()

func _process(delta):
	if Input.is_action_just_pressed("ui_left") && pressed == false:
		size_l = 2.0
		pressed = true
		_selected("left")
	if Input.is_action_just_pressed("ui_right") && pressed == false:
		size_r = 2.0
		pressed = true
		_selected("right")
	timerel = timer.time_left / timer.wait_time
	arrow_l.scale = Vector2.ONE * timerel * 0.3 * size_l
	arrow_r.scale = Vector2.ONE * timerel * 0.3 * size_r

#every time out this function starts and resets the timer and the selection
func _spawnfood():
	#if nothing is selected, it counts as a win for the opponent
	if foodholder.get_child(0) != null:
		foodholder.get_child(0).queue_free()
		if pressed == false:
			animplayer.play("miss")
			emit_signal("mistake")
			wrong.play()
	timer.start()
	pressed = false
	size_l = 1.0
	size_r = 1.0
	var foodid = randi()%food.size()
	
	newfood = food[foodid].instance()
	foodholder.add_child(newfood)
	animplayer.play("spawn")

#when global timer runs out, despawn
func _gameover():
	emit_signal("results")
	self.queue_free()

#playing appropriate animations, send bonus points
func _selected(var side):
	if side == "left":
		if newfood.is_in_group("food_l"):
			animplayer.play("moveleft")
			emit_signal("bonus", timerel, "left")
		else:
			animplayer.play("miss")
			emit_signal("mistake")
			wrong.play()
		
	else:
		if newfood.is_in_group("food_r"):
			animplayer.play("moveright")
			emit_signal("bonus", timerel, "right")
		else:
			animplayer.play("miss")
			emit_signal("mistake")
			wrong.play()

#spawn the effect
func _fxspawn():
	fx.position = foodholder.position
	fx.position.y -= 60.0
	fx.restart()
	randomize()
	#change pitch a little each time
	crunch.pitch_scale = 0.5 + randf()
	crunch.play()
