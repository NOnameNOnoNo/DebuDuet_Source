extends Node2D

const save_file = "res://config.cfg"

#saving the character choice into a .cfg file
func _savechoice(var charside):
	var config_file = ConfigFile.new()
	config_file.set_value("Config", "character", charside)
	config_file.save(save_file)
