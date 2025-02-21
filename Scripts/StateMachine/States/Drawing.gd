extends AState

var _current_line: Area2D

const LINE := preload("res://Scripts/Line.gd")

func enter() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/Graphics/Image/pencil-solid.svg"))

func exit() -> void:
	Input.set_custom_mouse_cursor(load("res://Assets/Graphics/Image/arrow-pointer-solid.svg"))

func input(event: InputEvent) -> IState:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				_current_line = DrawLine()
			else:
				if _current_line and is_instance_valid(_current_line):
					_current_line.Curve2D_Transformer(canvas._camera)
					# Delete the previous line if it didn't have any points or less than 2.
					# less than 2 because a bug could occure if you spam left click on a laptop:
					if _current_line._line.points.size() <= 2:
						_current_line.queue_free()
					
					canvas.snapshots.create_snapshot()
					
					return self
				
	elif event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_LEFT and _current_line and is_instance_valid(_current_line):
			_current_line._line.add_point(canvas.get_global_mouse_position())
			
	return null


func DrawLine() -> Area2D:
	_current_line = LINE.new()
	canvas._elements.add_child(_current_line)
	_current_line.Setup()
	_current_line.set_params(canvas.linewidth * canvas._camera.zoom.x, canvas.detached_RCC.color, canvas._camera.zoom)
	_current_line._line.add_point(canvas.get_global_mouse_position())
	
	return _current_line
