extends Node

#Class allowing to pass parameters from one scene to the next

# Private variable
var _params = null

func _ready():
	pass 


# Call this instead to be able to provide arguments to the next scene
func change_scene(next_scene, params=null):
	_params = params
	var _switched = get_tree().change_scene(next_scene)

# In the newly opened scene, you can get the parameters by name
func get_param(name):
	if _params != null and _params.has(name):
		return _params[name]
	return null
