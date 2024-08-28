extends ColorRect

func _input(event):
	if event is InputEventMouseMotion:
		# Move our cursor
		var mouse_motion : InputEventMouseMotion = event
		position = mouse_motion.position - Vector2(64, 64)
