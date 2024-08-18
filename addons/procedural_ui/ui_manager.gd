extends Node

signal current_section_selected(section_name)

var last_ui_element_focused = null
var sections_array : Array[UISectionResource] = []

## This variable stores the focused section 
var last_section_focused = null

var sections_container : Control :set = set_sections_container
var current_section_container : Control :set = set_current_section_container
var tts_player : AudioStreamPlayer :set = set_tts_player
var main_theme : Theme :set = set_main_theme
var ui_data : Dictionary :set = set_ui_data


func set_sections_container(new_value):
	sections_container = new_value


func set_current_section_container(new_value):
	current_section_container = new_value


func set_tts_player(new_value):
	tts_player = new_value
	# TODO
	# add warnings if tts_player is not defined


func set_main_theme(new_value):
	main_theme = new_value


func set_ui_data(data):
	ui_data = data
	if "main_theme" in data.keys():
		set_main_theme(ui_data["main_theme"])
	if "back_operator" in data.keys():
		generate_back_button_section_resource(ui_data["back_operator"])
	generate_sections_resources(ui_data["sections"])


func generate_sections_resources(data):
	for section in data:
		generate_section_resource(data[section], section)


func generate_section_resource(section, section_name):
	var resource = UISectionResource.new()
	resource.section_name = section_name
	resource.label_text = section.label
	resource.elements_data = section.data
	resource.theme = section.theme
	if "tts_file" in section.keys():
		resource.tts_file = section.tts_file
	sections_array.append(resource)
	return resource


func populate_current_section(current_section):
	last_section_focused = current_section
	for child in current_section_container.get_children():
		child.queue_free()
	for section in sections_array:
		if section.section_name == current_section:
			var section_element = section.get_ui_section_element()
			if section.theme:
				current_section_container.theme = section.theme
			current_section_container.add_child(Panel.new())
			current_section_container.add_child(section_element)
			section.grab_focus()
			populate_sections_selector_back()
			current_section_selected.emit(current_section)


func update_sections():
	for section in sections_array:
		section.update_section()



func populate_sections_selector():
	for child in sections_container.get_children():
		sections_container.remove_child(child)
		child.queue_free()
	if is_instance_valid(main_theme):
		sections_container.theme = main_theme
	sections_container.add_child(Panel.new())
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	for section in sections_array:
		var button = section.get_ui_element()
		if section.theme:
				button.theme = section.theme
		vbox.add_child(button)
	sections_container.add_child(vbox)
	sections_selector_grab_focus()


func populate_sections_selector_back():
	for child in sections_container.get_children():
		sections_container.remove_child(child)
		child.queue_free()
	var button = Button.new()
	button.text = "< BACK"
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.pressed.connect(func():
		populate_sections_selector()
		current_section_selected.emit("")
		)
	sections_container.add_child(button)



func generate_back_button_section_resource(data):
	var resource = generate_operator_resource
	#var button_data_name = data.keys()[0]
	#var button_data = data[button_data_name]
	#var resource = UISectionResource.new()
	#resource.section_name = button_data_name
	#resource.label_text = button_data.label
	#resource.elements_data = button_data.data
	#resource.theme = button_data.theme
	return resource


func back_operator():
	populate_sections_selector()
	current_section_selected.emit("")






func sections_selector_grab_focus():
	if last_section_focused:
		for section in sections_array:
			if section.section_name == last_section_focused:
				var index = sections_array.find(section)
				sections_container.get_children()[1].get_children()[index].call_deferred("grab_focus")
	else:
		sections_container.get_children()[1].get_children()[0].call_deferred("grab_focus")



func get_attribute_value(object, attr):
	var singleton = UIManager.get_tree().root.get_node(object)
	return singleton[attr]


func get_options(object, options_name):
	var singleton = UIManager.get_tree().root.get_node(object)
	return singleton[options_name]


func generate_boolean_resource(data):
	var resource = UIBoolAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip
	resource.object_name = data.object
	resource.attribute_name = data.attr
	if "checkbutton" in data.keys():
		resource.checkbutton = data.checkbutton
	resource.value = get_attribute_value(data.object, data.attr)
	if "tts_file" in data.keys():
		resource.tts_file = data.tts_file
	return resource


func generate_operator_resource(data):
	var resource = UIOperatorAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip
	resource.object_name = data.object
	resource.attribute_name = data.attr
	if "poll" in data.keys():
		resource.poll = data.poll
	if "tts_file" in data.keys():
		resource.tts_file = data.tts_file
	return resource


func generate_float_resource(data):
	var resource = UIFloatAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.value = get_attribute_value(data.object, data.attr)
	resource.min = data.min
	resource.max = data.max
	if "tts_file" in data.keys():
		resource.tts_file = data.tts_file
	return resource


func generate_int_resource(data):
	var resource = UIIntAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.value = get_attribute_value(data.object, data.attr)
	resource.min = data.min
	resource.max = data.max
	if "tts_file" in data.keys():
		resource.tts_file = data.tts_file
	return resource


func generate_options_resource(data):
	var resource = UIOptionsAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.value = get_attribute_value(data.object, data.attr)
	var options = get_options(data.object, data.options)
	for option in options:
		resource.options.append(option)
	if "tts_file" in data.keys():
		resource.tts_file = data.tts_file
	if "options_tts_files" in data.keys():
		for item in data.options_tts_files:
			resource.options_tts_files.append(item)
	return resource
