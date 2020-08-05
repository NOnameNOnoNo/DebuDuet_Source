extends Node2D

var label
export var charname = "NAME"

func _ready():
	label = $text
	_statsupd(0.0, 0.0, 0.0)


func _statsupd(var score, var multiplier, var level):
	score = floor(score * 10.0) / 10.0
	multiplier = floor(multiplier * 10.0) / 10.0
	label.text = charname + "\n Calories: " + str(score) + "\n Multiplier: " + str(multiplier) + "\n Level: " + str(level)
