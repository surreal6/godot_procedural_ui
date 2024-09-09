class_name UISectionResource
extends UIContainerResource

@export var section_name : String = ""
@export var label_text : String = ""
@export var tts_file : String = ""
@export var theme : Theme


func _init(data) -> void:
	super(data)
	section_name = data.section_name
	label_text = data.label
	elements_data = data.items
	theme = data.theme
	if "tts_file" in data.keys():
		tts_file = data.tts_file


func get_custom_class() -> String:
	return "UISectionResource"


func get_ui_container() -> Control:
	elements_array = []
	var section = VBoxContainer.new()
	section.alignment = BoxContainer.ALIGNMENT_CENTER
	section.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for attr in elements_data:
		var data = elements_data[attr]
		data.attr = attr
		var resource = UIManager.generate_resource(data)
		var element = resource.get_ui_element()
		section.add_child(element)
		elements_array.append(resource)
	section.visibility_changed.connect(update_elements_array)
	section.theme = theme
	ui_container = section
	return section


## SECTION BUTTON
func get_ui_element():
	var button = Button.new()
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.text = label_text
	button.pressed.connect(func():
		UIManager.populate_current_section(self.section_name)
		)
	button.gui_input.connect(func(event):
		_on_event(event))
	button.mouse_entered.connect(_register_as_last_hovered)
	button.mouse_exited.connect(_unregister_as_last_hovered)
	button.focus_entered.connect(_register_as_last_focused)
	button.focus_exited.connect(_unregister_as_last_focused)
	ui_element = button
	return button


func _on_event(event: InputEvent):
	if event.is_action_pressed("ui_right"):
		ui_element.pressed.emit()


func _register_as_last_focused() -> void:
	#print("register section button %s" % ui_element.name)
	UIManager.new_focused_target = ui_element
	if tts_file:
		UIManager.play_tts_file(tts_file)


func _unregister_as_last_focused() -> void:
	#print("unregister section button %s" % ui_element.name)
	UIManager.new_focused_target = null
	if tts_file:
		UIManager.stop_tts()


func _register_as_last_hovered() -> void:
	#print("register section button %s" % ui_element.name)
	UIManager.new_hovered_target = ui_element
	if tts_file:
		UIManager.play_tts_file(tts_file)


func _unregister_as_last_hovered() -> void:
	#print("unregister section button %s" % ui_element.name)
	UIManager.new_hovered_target = null
	if tts_file:
		UIManager.stop_tts()
