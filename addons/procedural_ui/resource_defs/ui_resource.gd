class_name UIResource
extends Resource

@export var object_name : String = ""
@export var visibility_poll : String = ""
@export var visibility_poll_object : String = ""

var mockup = false

var ui_element : Control
var ui_container : Control


func get_ui_resource_class() -> String:
	return "UIResource"


func get_singleton() -> Object:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	if !singleton:
		push_warning("UIManager: singleton '%s' not found" % object_name)
		push_warning("UIManager: Activate mockup for '%s' attributes" % object_name)
		mockup = true
	return singleton


func is_visible() -> bool:
	if visibility_poll_object:
		pass
	var singleton = get_singleton()
	if mockup:
		return true
	if visibility_poll != "":
		if !singleton.has_method(visibility_poll):
			push_warning("UIManager: visibility_poll method '%s' not found" % visibility_poll)
			return false
		var poll_result = singleton.call(visibility_poll)
		return poll_result
	return true
