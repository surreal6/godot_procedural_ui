extends Resource
class_name UISectionResource

@export var label_text : String = ""
@export var section_name : String = ""
@export var elements_data : Dictionary
@export var tts_file : String = ""
@export var theme : Theme

var elements_array : Array[UIAttributeResource] = []

var ui_element = Control
var ui_section_element = Control


func get_ui_section_element() -> Control:
	elements_array = []
	var section = VBoxContainer.new()
	section.alignment = BoxContainer.ALIGNMENT_CENTER
	section.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for attr in elements_data:
		var data = elements_data[attr]
		data.attr = attr
		if data.type == "bool":
			var resource = UIManager.generate_boolean_resource(data)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if data.type == "float":
			var resource = UIManager.generate_float_resource(data)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if data.type == "int":
			var resource = UIManager.generate_int_resource(data)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if data.type == "options":
			var resource = UIManager.generate_options_resource(data)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
		if data.type == "operator":
			var resource = UIManager.generate_operator_resource(data)
			var element = resource.get_ui_element()
			section.add_child(element)
			elements_array.append(resource)
	section.visibility_changed.connect(update_section)
	ui_section_element = section
	return section


func grab_focus():
	elements_array[0].ui_element.call_deferred("grab_focus")
	return elements_array[0].ui_element


func update_section():
	for element in elements_array:
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
	button.focus_entered.connect(_register_as_last_focused)
	button.focus_exited.connect(_unregister_as_last_focused)
	ui_element = button
	return button


func _on_event(event: InputEvent):
	if event.is_action_pressed("ui_right"):
		ui_element.pressed.emit()


func _register_as_last_focused() -> void:
	UIManager.last_ui_element_focused = ui_element
	#print("register section button %s" % ui_element.name)
	if tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		UIManager.tts_player.play()


func _unregister_as_last_focused() -> void:
	UIManager.last_ui_element_focused = null
	#print("unregister section button %s" % ui_element.name)
	if tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
