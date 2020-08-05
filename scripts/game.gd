extends Node2D

var char1
var char2
var label1
var label2
var char1name = "NULL"
var char2name = "NULL"
var timer
var filetoload = "res://config.cfg" 
var hint

# Called when the node enters the scene tree for the first time.
func _ready():
	#get nodes
	char1 = $char1
	char2 = $char2
	label1 = $stats1/text
	label2 = $stats2/text
	char1name = $stats1.charname
	char2name = $stats2.charname
	timer = $exit
	hint = $hint
	var configFile= ConfigFile.new() 
	configFile.load(filetoload)
	
	if (configFile.has_section_key("Config", "character")): 
		var yourchar = configFile.get_value("Config", "character") 
		print(yourchar)
		if char1.side != yourchar:
			char1.bot = true
			char2.bot = false
			#align right
			hint.align = 2
		if char2.side != yourchar:
			char1.bot = false
			char2.bot = true
			#align left
			hint.align = 0

#display results and start the fadeout timer
func _winner():
	timer.start()
	var scorel = char1.score
	var scorer = char2.score
	var diff = scorel - scorer
	if diff > 0.0:
		label1.text = char1name + "\n won!"
		label2.text = char2name + "\n lost!"
		char1._youwon()
	if diff < 0.0:
		label1.text = char1name + "\n lost!"
		label2.text = char2name + "\n won!"
		char2._youwon()
	if floor(diff) == 0.0:
		label1.text = "Draw!"
		label2.text = label1.text
