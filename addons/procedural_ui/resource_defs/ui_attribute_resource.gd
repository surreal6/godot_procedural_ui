extends Resource
class_name UIAttributeResource

@export var label_text : String = ""
@export var tooltip : String = ""
@export var object_name : String = ""
@export var attribute_name : String = ""

var ui_element = Control


func _on_set_attribute_value(new_value) -> void:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	singleton[attribute_name] = new_value
	singleton.save()


func _register_as_last_focused() -> void:
	UIManager.last_ui_element_focused = ui_element
	print("register %s" % ui_element.name)


func _unregister_as_last_focused() -> void:
	UIManager.last_ui_element_focused = null
	print("unregister %s" % ui_element.name)
