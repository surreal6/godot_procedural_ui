class_name UIResource
extends Resource

@export var object_name : String = ""
@export var visibility_poll : String = ""
@export var visibility_poll_object : String = ""

var mockup = false

var ui_element : Control
var ui_container : Control


func _init(data) -> void:
	object_name = data.object if "object" in data.keys() else ""
	visibility_poll = data.visibility_poll if "visibility_poll" in data.keys() else ""
	visibility_poll_object = data.visibility_poll_object if (
		"visibility_poll_object") in data.keys() else ""


func get_custom_class() -> String:
	return "UIResource"


func get_singleton() -> Object:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	if !singleton:
		push_warning("UIManager: singleton '%s' not found" % object_name)
		push_warning("UIManager: Activate mockup for '%s' attributes" % object_name)
		mockup = true
	return singleton


func get_visibility_singleton() -> Object:
	var singleton = UIManager.get_tree().root.get_node(visibility_poll_object)
	if !singleton:
		push_warning("UIManager: singleton '%s' not found" % visibility_poll_object)
		push_warning("UIManager: Activate mockup for '%s' attributes" % visibility_poll_object)
		mockup = true
	return singleton


func is_visible() -> bool:
	if visibility_poll_object:
		var singleton = get_visibility_singleton()
		if !singleton.has_method(visibility_poll):
			push_warning("UIManager: visibility_poll_object method '%s' not found" % visibility_poll)
			return false
		var poll_result = singleton.call(visibility_poll)
		return poll_result
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
