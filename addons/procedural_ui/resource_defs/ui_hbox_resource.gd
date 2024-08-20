extends Resource
class_name UIHBoxResource

@export var elements_data : Dictionary

var elements_array : Array[UIAttributeResource] = []
var ui_element = Control


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
	hbox.visibility_changed.connect(update_hbox)
	update_hbox()
	ui_element = hbox
	return hbox


func grab_focus():
	elements_array[0].ui_element.call_deferred("grab_focus")
	return elements_array[0].ui_element


func update_hbox():
	for element in elements_array:
		element.update()
		if element.is_visible():
			element.ui_container.show()
		else:
			element.ui_container.hide()
