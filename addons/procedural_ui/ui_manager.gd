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

var slider_drag : bool = false

## This variable stores the focused section
var last_section_focused = null

var sections_container : Control :set = set_sections_container
var current_section_container : Control :set = set_current_section_container
var tts_player : AudioStreamPlayer :set = set_tts_player
var main_theme : Theme :set = set_main_theme
var ui_data : Dictionary :set = set_ui_data

var enable_text_to_speech : bool = true:
	set(value):
		enable_text_to_speech = value
		if not enable_text_to_speech and is_instance_valid(tts_player):
			tts_player.stop()

var enable_hover_click : bool = true:
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

var viewport : Viewport


## set functions

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


## set functions END


func _ready():
	if !Engine.is_editor_hint():
		_set_time_held(0.0)

	process_mode = PROCESS_MODE_ALWAYS


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
		if slider_drag:
			slider_drag = false
			_execute_release_click()
		_set_time_held(time_held + delta)
		if time_held > hover_click_hold_time:
			_execute_click()
	# no focused element
	elif not new_hovered_target and last_hovered_target:
		#print("no focused ------------")
		if slider_drag:
			slider_drag = false
			_execute_release_click()
		_set_time_held(0.0)
	# change focused element
	elif new_hovered_target != last_hovered_target:
		disconnect_tts_on_finished()
		#print("change focused ------------")
		if slider_drag:
			slider_drag = false
			_execute_release_click()
		_set_time_held(0.0)
	# same target
	elif new_hovered_target == last_hovered_target:
		#print("same target ------------")
		if !slider_drag:
			_set_time_held(time_held + delta)
			if time_held > hover_click_hold_time:
				_execute_click()

	# Update last values
	last_hovered_target = new_hovered_target
	last_hovered_item = new_hovered_item




func generate_sections_resources(sections_data):
	for section_key in sections_data:
		sections_data[section_key].section_name = section_key
		var resource = UISectionResource.new(sections_data[section_key])
		sections_array.append(resource)


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
		if section.is_visible():
			var button = section.get_ui_element()
			if section.theme:
					button.theme = section.theme
			vbox.add_child(button)
			sections_container.add_child(vbox)
	sections_selector_grab_focus()


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
			resource = UIBoolAttributeResource.new(data)
		"float":
			resource = UIFloatAttributeResource.new(data)
		"int":
			resource = UIIntAttributeResource.new(data)
		"options":
			resource = UIOptionsAttributeResource.new(data)
		"operator":
			resource = UIOperatorAttributeResource.new(data)
		"HBoxContainer":
			resource = UIHBoxResource.new(data)
	return resource


## back operator generic
func back_operator():
	populate_sections_selector()
	current_section_selected.emit("")

## HOVER CLICK
func _on_click_detected():
	_set_time_held(0.0)


func _set_time_held(p_time_held):
	time_held = p_time_held
	if is_instance_valid(cursor):
		cursor.material.set_shader_parameter("value", time_held/hover_click_hold_time)


func get_current_viewport():
	if is_instance_valid(viewport):
		return viewport
	return get_viewport()


func _execute_click():
	#print("execute click")
	var current_viewport = get_current_viewport()
	_set_time_held(0.0)
	var input_event = InputEventMouseButton.new()
	input_event.pressed = true
	input_event.position = current_viewport.get_mouse_position()
	input_event.button_index = MOUSE_BUTTON_LEFT
	current_viewport.push_input(input_event)
	
	# TODO emit volume sound to indicate value
	if is_instance_valid(new_hovered_target):
		if new_hovered_target.get_class() == "HSlider":
			slider_drag = true
			return

	input_event.pressed = false
	current_viewport.push_input(input_event)


func _execute_release_click():
	var current_viewport = get_current_viewport()
	var input_event = InputEventMouseButton.new()
	input_event.pressed = false
	input_event.position = current_viewport.get_mouse_position()
	input_event.button_index = MOUSE_BUTTON_LEFT
	current_viewport.push_input(input_event)


func reset_targets_and_items() -> void:
	last_hovered_target = null
	new_hovered_target = null
	last_hovered_item = -1
	new_hovered_item = -1
	new_focused_target = null
	last_focused_target = null
	new_focused_item  = -1

## HOVER CLICK END

## TTS Functions


func play_tts_on_finished(tts_file) -> void:
	if is_instance_valid(tts_player):
		disconnect_tts_on_finished()
		tts_player.finished.connect(func():
			play_tts_file(tts_file)
			disconnect_tts_on_finished()
		)


func disconnect_tts_on_finished() -> void:
	if is_instance_valid(tts_player):
		for item in tts_player.finished.get_connections():
			tts_player.finished.disconnect(item.callable)


func play_tts_file(tts_file) -> void:
	if enable_text_to_speech and is_instance_valid(tts_player):
		if tts_player.playing:
			tts_player.stop()
		tts_player.stream = load(tts_file)
		tts_player.play()


func stop_tts() -> void:
	if enable_text_to_speech and is_instance_valid(tts_player):
		if tts_player.playing:
			tts_player.stop()
