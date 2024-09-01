class_name UIContainerResource
extends UIResource

@export var elements_data : Dictionary

var elements_array : Array[UIResource] = []


func _init(data) -> void:
	super(data)
	elements_data = data.items



func get_ui_resource_class() -> String:
	return "UIContainerResource"


func grab_focus():
	for element in elements_array:
		if element.is_visible():
			#print("ui_section grab focus %s" % element.ui_element)
			element.ui_element.call_deferred("grab_focus")
			return element.ui_element


func update_elements_array():
	for element in elements_array:
		if element is UIContainerResource:
			element.update_elements_array()
		else:
			element.update()
			if is_instance_valid(element.ui_container):
				if element.is_visible():
					element.ui_container.show()
					element.ui_container.set_focus_mode(0)
				else:
					element.ui_container.hide()
					element.ui_container.set_focus_mode(2)
