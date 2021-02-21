extends Camera2D

func _process(delta):
	var vertical = Input.get_action_strength("down") - Input.get_action_strength("up")
	var horrizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var move := Vector2(horrizontal, vertical).normalized()
	position += move * delta * 1000 * zoom.x
	

func _input(event):
	if event.is_action_pressed("zoomIn"):
		zoom *= 0.9
	elif event.is_action_pressed("zoomOut"):
		zoom *= 1.1
