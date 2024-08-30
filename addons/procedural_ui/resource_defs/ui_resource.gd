class_name UIResource
extends Resource

@export var object_name : String = ""
@export var visibility_poll : String = ""

var ui_element : Control
var ui_container : Control


func is_visible() -> bool:
	if visibility_poll != "":
		var singleton = UIManager.get_tree().root.get_node(object_name)
		if !singleton.has_method(visibility_poll):
			push_warning("visibility_poll method '%s' not found" % visibility_poll)
			return false
		var poll_result = singleton.call(visibility_poll)
		return poll_result
	return true
