class_name UIResource
extends Resource

@export var object_name : String = ""
@export var visibility_poll : String = ""

var ui_element : Control
var ui_container : Control


func get_singleton() -> Object:
	return UIManager.get_tree().root.get_node(object_name)


func is_visible() -> bool:
	var singleton = get_singleton()
	if !singleton:
		push_warning("singleton '%s' not found" % object_name)
		return false
	if visibility_poll != "":
		if !singleton.has_method(visibility_poll):
			push_warning("visibility_poll method '%s' not found" % visibility_poll)
			return false
		var poll_result = singleton.call(visibility_poll)
		return poll_result
	return true
