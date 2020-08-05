extends Control

#initial time
export var time = 120.0
#this signal triggers stuff after the timeout
signal timeout
#text label displaying time
var text
#one-shot timer node
var timer
#this bool allows to switch from counting in _process() to displaying different text
var counting = true

func _ready():
	#get the nodes
	text = $cdtext
	timer = $timer
	#set the initial time and start the timer
	timer.wait_time = time
	timer.start()

func _process(delta):
	#as long as timer is counting, set the text to remaining time
	if counting == true:
		var timeleft = timer.time_left
		#time formatting code converted from an example by user jashan on Unity forums
		var minutes = floor(timeleft / 60.0)
		var seconds = floor(timeleft - minutes * 60.0)
		var niceTime = "%02d : %02d" % [minutes, seconds]
		text.text = niceTime

#this function, connected to the timer, changes the text and emits the signal
func _depleted():
	counting = false
	emit_signal("timeout")
	text.text = "TIME OUT!"
