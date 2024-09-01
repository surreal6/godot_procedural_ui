class_name UIHBoxResource
extends UIContainerResource


func get_custom_class() -> String:
	return "UIHBoxResource"

func get_ui_element() -> Control:
	elements_array = []
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for attr in elements_data:
		var data = elements_data[attr]
		data.attr = attr
		var resource = UIManager.generate_resource(data)
		var element = resource.get_ui_element()
		hbox.add_child(element)
		elements_array.append(resource)
	hbox.visibility_changed.connect(update_elements_array)
	ui_element = hbox
	ui_container = hbox
	return hbox
