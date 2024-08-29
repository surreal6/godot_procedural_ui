class_name UIHBoxResource
extends UIContainerResource


func get_ui_element() -> Control:
	elements_array = []
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for attr in elements_data:
		var data = elements_data[attr]
		data.attr = attr
		var resource = UIManager.generate_resource(data)
		var element = resource.get_ui_element()
		hbox.add_child(element)
		elements_array.append(resource)
	hbox.visibility_changed.connect(update)
	update()
	ui_element = hbox
	ui_container = hbox
	return hbox


func grab_focus():
	elements_array[0].ui_element.call_deferred("grab_focus")
	return elements_array[0].ui_element


func update():
	for element in elements_array:
		element.update()
		if is_instance_valid(element.ui_container):
			if element.is_visible():
				element.ui_container.show()
				element.ui_container.set_focus_mode(0)

			else:
				element.ui_container.hide()
				element.ui_container.set_focus_mode(2)

func is_visible():
	if visibility_poll != "":
		var singleton = UIManager.get_tree().root.get_node(object_name)
		var poll_result = singleton.call(visibility_poll)
		return poll_result
	return true
