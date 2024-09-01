extends Node

signal current_section_selected(section_name)

var sections_array : Array[UISectionResource] = []

var time_held = 0.0
var hover_click_hold_time : float = 2.0

## This variables stores the focused element
var new_focused_target : Control = null
var last_focused_target : Control = null
var new_focused_item : int = -1

## This variables stores the hovered element
var new_hovered_target : Control = null
var last_hovered_target : Control = null
var new_hovered_item : int = -1
var last_hovered_item : int = -1

## This variable stores the focused section
var last_section_focused = null

var sections_container : Control :set = set_sections_container
var current_section_container : Control :set = set_current_section_container
var tts_player : AudioStreamPlayer :set = set_tts_player
var main_theme : Theme :set = set_main_theme
var ui_data : Dictionary :set = set_ui_data

var enable_text_to_speech : bool = false:
	set(value):
		enable_text_to_speech = value
		if not enable_text_to_speech and is_instance_valid(tts_player):
			tts_player.stop()

var enable_hover_click : bool = false:
	set(value):
		enable_hover_click = value
		if not value and is_instance_valid(cursor):
			cursor.material.set_shader_parameter("value", 0.0)

var cursor : ColorRect
var cursor_canvas_layer : CanvasLayer:
	set(value):
		cursor_canvas_layer = value
		cursor = cursor_canvas_layer.cursor
		cursor_canvas_layer.click_detected.connect(_on_click_detected)


func _on_click_detected():
	_set_time_held(0.0)


func _ready():
	if !Engine.is_editor_hint():
		_set_time_held(0.0)

	enable_hover_click = UserSettings.hover_click
	enable_text_to_speech = UserSettings.text_to_speech


func _process(delta):
	if !enable_hover_click:
		return

	# If no current or previous collisions then skip
	if not is_instance_valid(new_hovered_target) and not is_instance_valid(last_hovered_target):
		if is_instance_valid(cursor):
			cursor.material.set_shader_parameter("value", 0.0)
		return

	if new_hovered_item != last_hovered_item and last_hovered_item != -1:
		_set_time_held(0.0)

	if new_hovered_item == -1  and last_hovered_item != -1:
		_set_time_held(0.0)

	if new_hovered_target and not last_hovered_target:
		#print("new target ------------")
		_set_time_held(time_held + delta)
		if time_held > hover_click_hold_time:
			_execute_click()
	# no focused element
	elif not new_hovered_target and last_hovered_target:
		#print("no focused ------------")
		_set_time_held(0.0)
	# change focused element
	elif new_hovered_target != last_hovered_target:
		#print("change focused ------------")
		_set_time_held(0.0)
	# same target
	elif new_hovered_target == last_hovered_target:
		#print("same target ------------")
		_set_time_held(time_held + delta)
		if time_held > hover_click_hold_time:
			_execute_click()

	# Update last values
	last_hovered_target = new_hovered_target
	last_hovered_item = new_hovered_item


func _set_time_held(p_time_held):
	time_held = p_time_held
	if is_instance_valid(cursor):
		cursor.material.set_shader_parameter("value", time_held/hover_click_hold_time)



func _execute_click():
	#print("execute click")
	_set_time_held(0.0)
	var input_event = InputEventMouseButton.new()
	input_event.pressed = true
	input_event.position = get_viewport().get_mouse_position()
	input_event.button_index = MOUSE_BUTTON_LEFT
	get_viewport().push_input(input_event)
	input_event.pressed = false
	get_viewport().push_input(input_event)


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
			var section_element = section.get_ui_container()
			if section.theme:
				current_section_container.theme = section.theme
			var panel = Panel.new()
			panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
			panel.mouse_force_pass_scroll_events = false
			current_section_container.add_child(panel)
			current_section_container.add_child(section_element)
			section.grab_focus()
			current_section_selected.emit(current_section)


func update_sections():
	for section in sections_array:
		section.update_elements_array()


func populate_sections_selector():
	for child in sections_container.get_children():
		sections_container.remove_child(child)
		child.queue_free()
	if is_instance_valid(main_theme):
		sections_container.theme = main_theme
	var panel = Panel.new()
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sections_container.add_child(panel)
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	for section in sections_array:
		var button = section.get_ui_element()
		if section.theme:
				button.theme = section.theme
		vbox.add_child(button)
	sections_container.add_child(vbox)
	sections_selector_grab_focus()


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


func generate_resource(data):
	var resource
	match data.type:
		"bool":
			resource = UIManager.generate_boolean_resource(data)
		"float":
			resource = UIManager.generate_float_resource(data)
		"int":
			resource = UIManager.generate_int_resource(data)
		"options":
			resource = UIManager.generate_options_resource(data)
		"operator":
			resource = UIManager.generate_operator_resource(data)
		"HBoxContainer":
			resource = UIManager.generate_hbox_resource(data)
	return resource


func generate_boolean_resource(data):
	var resource = UIBoolAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip if "tooltip" in data.keys() else ""
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.poll = data.poll if "poll" in data.keys() else ""
	resource.stretch_ratio = data.stretch_ratio if "stretch_ratio" in data.keys() else 1
	resource.inline_label = data.inline_label if "inline_label" in data.keys() else false
	resource.checkbutton = data.checkbutton if "CheckButton" in data.keys() else false
	resource.value = resource.get_attribute_value()
	resource.tts_file = data.tts_file if "tts_file"  in data.keys() else ""
	resource.visibility_poll = data.visibility_poll if "visibility_poll" in data.keys() else ""
	return resource


func generate_operator_resource(data):
	var resource = UIOperatorAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip if "tooltip" in data.keys() else ""
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.stretch_ratio = data.stretch_ratio if "stretch_ratio" in data.keys() else 1
	resource.poll = data.poll if "poll" in data.keys() else ""
	resource.tts_file = data.tts_file if "tts_file"  in data.keys() else ""
	resource.visibility_poll = data.visibility_poll if "visibility_poll" in data.keys() else ""
	return resource


func generate_float_resource(data):
	var resource = UIFloatAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip if "tooltip" in data.keys() else ""
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.poll = data.poll if "poll" in data.keys() else ""
	resource.value = resource.get_attribute_value()
	resource.min = data.min
	resource.max = data.max
	resource.step = data.step if "step" in data.keys() else 0.01
	resource.tick_count = data.tick_count if "tick_count" in data.keys() else 0
	resource.ticks_on_borders = data.ticks_on_borders if "ticks_on_borders" in data.keys() else false
	resource.stretch_ratio = data.stretch_ratio if "stretch_ratio" in data.keys() else 1
	resource.tts_file = data.tts_file if "tts_file"  in data.keys() else ""
	resource.visibility_poll = data.visibility_poll if "visibility_poll" in data.keys() else ""
	return resource


func generate_int_resource(data):
	var resource = UIIntAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip if "tooltip" in data.keys() else ""
	resource.object_name = data.object
	resource.attribute_name = data.attr
	resource.poll = data.poll if "poll" in data.keys() else ""
	resource.value = resource.get_attribute_value()
	resource.min = data.min
	resource.max = data.max
	resource.step = data.step if "step" in data.keys() else 1
	resource.tick_count = data.tick_count if "tick_count" in data.keys() else 0
	resource.ticks_on_borders = data.ticks_on_borders if "ticks_on_borders" in data.keys() else false
	resource.stretch_ratio = data.stretch_ratio if "stretch_ratio" in data.keys() else 1
	resource.tts_file = data.tts_file if "tts_file"  in data.keys() else ""
	resource.visibility_poll = data.visibility_poll if "visibility_poll" in data.keys() else ""
	return resource


func generate_options_resource(data):
	var resource = UIOptionsAttributeResource.new()
	resource.label_text = data.label
	resource.tooltip = data.tooltip if "tooltip" in data.keys() else ""
	resource.object_name = data.object
	resource.options_name = data.options
	resource.poll = data.poll if "poll" in data.keys() else ""
	resource.attribute_name = data.attr
	resource.value = resource.get_attribute_value()
	resource.stretch_ratio = data.stretch_ratio if "stretch_ratio" in data.keys() else 1
	var options = resource.get_options()
	if options:
		for option in options:
			resource.options.append(option)
		resource.tts_file = data.tts_file if "tts_file"  in data.keys() else ""
		if "options_tts_files" in data.keys():
			for item in data.options_tts_files:
				resource.options_tts_files.append(item)
	resource.visibility_poll = data.visibility_poll if "visibility_poll" in data.keys() else ""
	return resource


func generate_hbox_resource(data):
	var resource = UIHBoxResource.new()
	resource.elements_data = data.items
	return resource
