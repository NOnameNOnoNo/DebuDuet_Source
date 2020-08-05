extends AudioStreamPlayer


func _process(delta):
	if Input.is_action_just_pressed("music"):
		#instead of stopping the music, toggle the volume
		if volume_db < 0.0:
			volume_db = 0.0
		else:
			volume_db = -50.0
