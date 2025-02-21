extends AState

func input(event: InputEvent) -> IState:
	var mouse_position: Vector2 = canvas.get_global_mouse_position()
	if Input.is_action_just_pressed("Zoom"):
		canvas._camera.update_zoom(event, mouse_position, true)
	elif Input.is_action_just_pressed("Unzoom"):
		canvas._camera.update_zoom(event, mouse_position, false)

	return switch_to_previous_state()
