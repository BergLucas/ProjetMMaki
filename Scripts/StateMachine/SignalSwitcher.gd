extends IState

# Selection nodes to set with the Godot engine.
export (NodePath) var zoom_camera_node
export (NodePath) var move_canvas_node
export (NodePath) var drawing_node
export (NodePath) var selection_node
export (NodePath) var copy_node
export (NodePath) var paste_node
export (NodePath) var delete_node
export (NodePath) var drag_and_drop_node
export (NodePath) var rescale_node
export (NodePath) var rotation_node
export (NodePath) var undo_node
export (NodePath) var redo_node
export (NodePath) var group_node
export (NodePath) var ungroup_node
export (NodePath) var create_title_node
export (NodePath) var pen_size_node
export (NodePath) var svg_save_node
export (NodePath) var transform_node
#export (NodePath) var color_picker_node


onready var zoom_camera: IState = get_node(zoom_camera_node)
onready var move_canvas: IState = get_node(move_canvas_node)
onready var drawing: IState = get_node(drawing_node)
onready var selection: IState = get_node(selection_node)
onready var copy: IState = get_node(copy_node)
onready var paste: IState = get_node(paste_node)
onready var delete: IState = get_node(delete_node)
onready var drag_and_drop: IState = get_node(drag_and_drop_node)
onready var rescale: IState = get_node(rescale_node)
onready var rotation: IState = get_node(rotation_node)
onready var undo: IState = get_node(undo_node)
onready var redo: IState = get_node(redo_node)
onready var group: IState = get_node(group_node)
onready var ungroup: IState = get_node(ungroup_node)
onready var create_title: IState = get_node(create_title_node)
onready var pen_size: IState = get_node(pen_size_node)
onready var svg_save: IState = get_node(svg_save_node)
onready var transform: IState = get_node(transform_node)
#onready var color_picker: IState = get_node(color_picker_node)

"""
Function called to switch the state according to the keyboard input.

Parameters:
-----------
event: The input event to consume. (InputEvent)

Returns:
--------
The state to switch to. (IState)
"""
func keyboard_input(event: InputEvent) -> IState:
	if Input.is_action_just_pressed("Zoom") || Input.is_action_just_pressed("Unzoom"):
		var current_state: IState = get_node("../../StateManager").current_state
		if current_state == rescale or current_state == pen_size:
			return null
		else:
			return zoom_camera
	
	elif Input.is_action_just_pressed("MoveCanvas") and not Input.is_action_pressed("Ungroup"):
		return move_canvas
	
	if Input.is_action_just_pressed("Drawing"):
		return drawing
	
	if Input.is_action_just_pressed("Selection") and not Input.is_action_pressed("SVGSave"):
		return selection
	
	if Input.is_action_just_pressed("Copy"):
		return copy
	
	if Input.is_action_just_pressed("Paste"):
		return paste
	
	if Input.is_action_just_pressed("Delete"):
		return delete
	
	if Input.is_action_just_pressed("DragAndDrop"):
		return drag_and_drop
	
	if Input.is_action_just_pressed("Rotation"):
		return rotation
	
	if Input.is_action_just_pressed("Undo"):
		return undo
	elif event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_Z and not event.control:
			return rescale
		
	if Input.is_action_just_pressed("Redo"):
		return redo
	
	if Input.is_action_just_pressed("Group") and not Input.is_action_pressed("Ungroup"):
		print("group")
		return group
	
	if Input.is_action_just_pressed("Ungroup"):
		print("ungroup")
		return ungroup
	
	if Input.is_action_pressed("CreateTitle"):
		if Input.is_action_pressed("1") or Input.is_action_pressed("2") or Input.is_action_pressed("3"):
			return create_title
	
	if Input.is_action_just_pressed("PenSize"):
		return pen_size
	
	if Input.is_action_just_pressed("SVGSave"):
		return svg_save
	
	if Input.is_action_just_pressed("Transform"):
		return transform
	
#	if Input.is_action_just_pressed("ColorPicker"):
#		return color_picker
	
	return null

"""
Function called to switch to the previous state.
"""
func switch_to_previous_state() -> IState:
	return get_node("../../StateManager").previous_state

"""
Function called to switch the state according to a signal.

Parameters:
-----------
state: The next state to switch to. (String)

Returns:
--------
The state to transit to. (IState)
"""
func switch_signal(state: String) -> IState:
	match state:
		"MoveCanvas":
			return move_canvas
		"Drawing":
			return drawing
		"Selection":
			return selection
		"Copy":
			return copy
		"Paste":
			return paste
		"Delete":
			return delete
		"DragAndDrop":
			return drag_and_drop
		"Rescale":
			return rescale
		"Rotation":
			return rotation
		"Undo":
			return undo
		"Redo":
			return redo
		"Group":
			return group
		"Ungroup":
			return ungroup
		"CreateTitle":
			return create_title
		"PenSize":
			return pen_size
		"SVGSave":
			return svg_save
		"Transform":
			return transform
#		"ColorPicker":
#			return color_picker
		_:
			return null



