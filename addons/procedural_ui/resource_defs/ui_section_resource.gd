class_name UISectionResource
extends Resource

@export var label_text : String = ""
@export var section_name : String = ""
@export var elements_data : Dictionary
@export var tts_file : String = ""
@export var theme : Theme

var elements_array : Array[Resource] = []

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
		var resource = UIManager.generate_resource(data)
		var element = resource.get_ui_element()
		section.add_child(element)
		elements_array.append(resource)
	section.visibility_changed.connect(update_section)
	update_section()
	section.theme = theme
	ui_section_element = section
	return section


func grab_focus():
	for element in elements_array:
		if element.is_visible():
			element.ui_element.call_deferred("grab_focus")
			return element.ui_element


func update_section():
	for element in elements_array:
		element.update()
		if  is_instance_valid(element.ui_container):
			if element.is_visible():
				element.ui_container.show()
				element.ui_container.set_focus_mode(0)
			else:
				element.ui_container.hide()
				element.ui_container.set_focus_mode(2)


## SECTION BUTTON

func get_ui_element():
	var button = Button.new()
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
	UIManager.new_focused_target = ui_element
	#print("register section button %s" % ui_element.name)
	play_tts_attribute()


func _unregister_as_last_focused() -> void:
	UIManager.new_focused_target = null
	#print("unregister section button %s" % ui_element.name)
	stop_tts()


func _register_as_last_hovered() -> void:
	UIManager.new_hovered_target = ui_element
	#print("register section button %s" % ui_element.name)
	play_tts_attribute()


func _unregister_as_last_hovered() -> void:
	UIManager.new_hovered_target = null
	#print("unregister section button %s" % ui_element.name)
	stop_tts()


func play_tts_attribute() -> void:
	if UIManager.enable_tts and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		UIManager.tts_player.play()


func stop_tts() -> void:
	if UIManager.enable_tts and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
