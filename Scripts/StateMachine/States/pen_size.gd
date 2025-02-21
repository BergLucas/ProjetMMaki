extends AState

func input(_event: InputEvent) -> IState:
	if not canvas.pm.visible:
		
		canvas.pm.clear()
		canvas.pm.get_node("HSlider").value = canvas.linewidth
		canvas.pm.get_node("HSlider").visible = true

		var _text_popup = canvas.get_node("CanvasLayer/RightClickContainer/Pen size")
		canvas.pm.popup(Rect2(_text_popup.get_global_rect().position.x - 154, _text_popup.get_global_rect().position.y, 100, 100))
		canvas.pm.get_node("pensizecircle").set_line_size(canvas.linewidth)
		canvas.pm.get_node("pensizecircle").set_line_color(canvas.RCC.color)
		canvas.pm.get_node("pensizecircle").visible = true
	
	return null

func physics_process(_delta: float) -> IState:
	
	if not canvas.pm.visible:
		canvas.pm.visible = true
	
	if not Rect2(canvas.pm.get_node("HSlider").get_global_position(), canvas.pm.get_node("HSlider").rect_size).has_point(canvas.get_global_mouse_position()):
		var line_size: int = canvas.linewidth
		if Input.is_action_just_released("Zoom") and line_size < 10:
			canvas.pm.get_node("HSlider").value = line_size + 1
		elif Input.is_action_just_released("Unzoom") and line_size > 0:
			canvas.pm.get_node("HSlider").value = line_size - 1
		
	return null

func parametrized_call(args: Array) -> IState:
	if args[0] >= 0:
		canvas.pm.get_node("pensizecircle").set_line_size(args[0])
		canvas.linewidth = args[0]
	else:
		if not Rect2(Vector2(),canvas.pm.get_node("HSlider").rect_size).has_point(canvas.pm.get_node("HSlider").get_local_mouse_position()):
			canvas.pm.hide()
			return switch_to_previous_state()
	
	return null
