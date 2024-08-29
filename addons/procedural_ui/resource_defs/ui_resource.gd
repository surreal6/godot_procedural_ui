class_name UIResource
extends Resource

@export var object_name : String = ""
@export var visibility_poll : String = ""

var ui_element : Control


func is_visible() -> bool:
	if visibility_poll != "":
		var singleton = UIManager.get_tree().root.get_node(object_name)
		var poll_result = singleton.call(visibility_poll)
		return poll_result
	return true