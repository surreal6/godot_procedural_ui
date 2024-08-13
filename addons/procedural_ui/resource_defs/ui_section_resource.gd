extends Resource
class_name UISectionResource

@export var label_text : String = ""
@export var object_name : String = ""
@export var elements_data_name : String = ""
@export var elements_array : Array[UIAttributeResource] = []

var elements_data : Dictionary
var ui_element = Control
var ui_section_element = Control


func get_elements_data() -> void:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	elements_data = singleton[elements_data_name]


func get_attribute_value(object, attr):
	var singleton = UIManager.get_tree().root.get_node(object)
	return singleton[attr]


func get_options(object, options_name):
	var singleton = UIManager.get_tree().root.get_node(object)
	return singleton[options_name]


func get_ui_section_element() -> Control:
	var section = VBoxContainer.new()
	section.alignment = BoxContainer.ALIGNMENT_CENTER
	section.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	get_elements_data()
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
	return section


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
		print(option)
	return resource


func update_section():
	print("update section")
	for element in elements_array:
		print("element %s" % element.attribute_name)
		element.update()


## SECTION BUTTON

func get_ui_element():
	var hbox = HBoxContainer.new()
	var button = Button.new()
	button.text = label_text
	button.visibility_changed.connect(update_section_button)
	button.mouse_entered.connect(_register_as_last_focused)
	button.mouse_exited.connect(_unregister_as_last_focused)
	hbox.add_child(button)
	ui_element = button
	return hbox


func update_section_button() -> void:
	pass


func _register_as_last_focused() -> void:
	UIManager.last_ui_element_focused = ui_element
	print("register %s" % ui_element.name)


func _unregister_as_last_focused() -> void:
	UIManager.last_ui_element_focused = null
	print("unregister %s" % ui_element.name)
