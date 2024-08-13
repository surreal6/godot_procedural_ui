extends Resource
class_name UISectionResource

@export var label_text : String = ""
@export var section_name : String = ""
@export var elements_data : Dictionary
@export var theme : Theme

var elements_array : Array[UIAttributeResource] = []

var ui_element = Control
var ui_section_element = Control


func get_attribute_value(object, attr):
	var singleton = UIManager.get_tree().root.get_node(object)
	return singleton[attr]


func get_options(object, options_name):
	var singleton = UIManager.get_tree().root.get_node(object)
	return singleton[options_name]


func get_ui_section_element() -> Control:
	elements_array = []
	var section = VBoxContainer.new()
	section.alignment = BoxContainer.ALIGNMENT_CENTER
	section.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for attr in elements_data:
		if elements_data[attr].type == "bool":
			var resource = generate_boolean_resource(attr)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if elements_data[attr].type == "float":
			var resource = generate_float_resource(attr)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if elements_data[attr].type == "int":
			var resource = generate_int_resource(attr)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if elements_data[attr].type == "options":
			var resource = generate_options_resource(attr)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if elements_data[attr].type == "operator":
			var resource = generate_operator_resource(attr)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
	section.visibility_changed.connect(update_section)
	ui_section_element = section
	return section


func grab_focus():
	elements_array[0].ui_element.call_deferred("grab_focus")
	return elements_array[0].ui_element


func generate_operator_resource(attr):
	var resource = UIOperatorAttributeResource.new()
	resource.label_text = elements_data[attr].label
	resource.tooltip = elements_data[attr].tooltip
	resource.object_name = elements_data[attr].object
	resource.attribute_name = attr
	if "poll" in elements_data[attr].keys():
		resource.poll = elements_data[attr].poll
	return resource


func generate_boolean_resource(attr):
	var resource = UIBoolAttributeResource.new()
	resource.label_text = elements_data[attr].label
	resource.tooltip = elements_data[attr].tooltip
	resource.object_name = elements_data[attr].object
	resource.attribute_name = attr
	if "checkbutton" in elements_data[attr].keys():
		resource.checkbutton = elements_data[attr].checkbutton
	resource.value = get_attribute_value(elements_data[attr].object, attr)
	return resource


func generate_float_resource(attr):
	var resource = UIFloatAttributeResource.new()
	resource.label_text = elements_data[attr].label
	resource.tooltip = elements_data[attr].tooltip
	resource.object_name = elements_data[attr].object
	resource.attribute_name = attr
	resource.value = get_attribute_value(elements_data[attr].object, attr)
	resource.min = elements_data[attr].min
	resource.max = elements_data[attr].max
	return resource


func generate_int_resource(attr):
	var resource = UIIntAttributeResource.new()
	resource.label_text = elements_data[attr].label
	resource.tooltip = elements_data[attr].tooltip
	resource.object_name = elements_data[attr].object
	resource.attribute_name = attr
	resource.value = get_attribute_value(elements_data[attr].object, attr)
	resource.min = elements_data[attr].min
	resource.max = elements_data[attr].max
	return resource


func generate_options_resource(attr):
	var resource = UIOptionsAttributeResource.new()
	resource.label_text = elements_data[attr].label
	resource.tooltip = elements_data[attr].tooltip
	resource.object_name = elements_data[attr].object
	resource.attribute_name = attr
	resource.value = get_attribute_value(elements_data[attr].object, attr)
	var options = get_options(elements_data[attr].object, elements_data[attr].options)
	for option in options:
		resource.options.append(option)
		#print(option)
	return resource


func update_section():
	#print("update section")
	for element in elements_array:
		#print("element %s" % element.attribute_name)
		element.update()


## SECTION BUTTON

func get_ui_element():
	var button = Button.new()
	button.text = label_text
	button.pressed.connect(func():
		UIManager.populate_current_section(self.section_name)
		)
	button.gui_input.connect(func(event):
		_on_event(event))
	button.mouse_entered.connect(_register_as_last_focused)
	button.mouse_exited.connect(_unregister_as_last_focused)
	ui_element = button
	return button


func _on_event(event: InputEvent):
	if event.is_action_pressed("ui_right"):
		ui_element.pressed.emit()


func _register_as_last_focused() -> void:
	UIManager.last_ui_element_focused = ui_element
	#print("register section button %s" % ui_element.name)


func _unregister_as_last_focused() -> void:
	UIManager.last_ui_element_focused = null
	#print("unregister section button %s" % ui_element.name)
