extends AudioStreamPlayer


func _process(delta):
	if Input.is_action_just_pressed("music"):
		#toggle the music
		if playing == true:
			stop()
		else:
			play()
