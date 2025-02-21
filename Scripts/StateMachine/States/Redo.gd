extends AState


func enter() -> void:
	canvas._action_menu.hide()

func input(event: InputEvent) -> IState:
	if event is InputEventKey:
		if event.scancode == KEY_Y and Input.is_key_pressed(KEY_CONTROL):
			canvas._elements = canvas.snapshots.get_next_snapshot()
			canvas.selected_lines = []
			
	return switch_to_previous_state()
