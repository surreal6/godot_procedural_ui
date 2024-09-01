class_name UIAttributeResource
extends UIResource

@export var attribute_name : String = ""
@export var label_text : String = ""
@export var tooltip : String = ""
@export var tts_file : String = ""
@export var poll : String = ""
@export var stretch_ratio : float = 1


func _init(data) -> void:
	super(data)
	attribute_name = data.attr
	label_text = data.label
	tooltip = data.tooltip if "tooltip" in data.keys() else ""
	tts_file = data.tts_file if "tts_file"  in data.keys() else ""
	poll = data.poll if "poll" in data.keys() else ""
	stretch_ratio = data.stretch_ratio if "stretch_ratio" in data.keys() else 1


func get_mockup_value():
	match get_custom_class():
		"UIBoolAttributeResource":
			return false
		"UIIntAttributeResource", "UIFloatAttributeResource":
			return 1
		"UIOptionsAttributeResource":
			return -1
	push_warning("need a mockup value for %s" % get_custom_class())


func get_attribute_value():
	var singleton = get_singleton()
	if attribute_name not in singleton:
		push_warning("UIManager: attribute '%s' not found" % attribute_name)
		push_warning("UIManager: Activate mockup for '%s'" % attribute_name)
		mockup = true
		return get_mockup_value()
	return singleton[attribute_name]


func _on_set_attribute_value(new_value) -> void:
	if mockup:
		return
	var singleton = get_singleton()
	singleton[attribute_name] = new_value
	singleton.save()
	UIManager.update_sections()


func _register_as_last_focused() -> void:
	UIManager.new_focused_target = ui_element
	#print("register focus %s" % ui_element.name)
	play_tts_attribute()


func _unregister_as_last_focused() -> void:
	UIManager.new_focused_target = null
	#print("unregister focus %s" % ui_element.name)
	stop_tts()


func _register_as_last_hovered() -> void:
	UIManager.new_hovered_target = ui_element
	#print("register hover %s" % ui_element.name)
	play_tts_attribute()


func _unregister_as_last_hovered() -> void:
	UIManager.new_hovered_target = null
	#print("unregister hover %s" % ui_element.name)
	stop_tts()


func play_tts_attribute() -> void:
	if UIManager.enable_text_to_speech and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		UIManager.tts_player.play()


func stop_tts() -> void:
	if UIManager.enable_text_to_speech and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()


func disable_ui_element(value) -> void:
	match ui_element.get_class():
		"CheckBox", "CheckButton", "CustomOptionButton":
			ui_element.disabled = value
		"HSlider":
			ui_element.editable = !value
	ui_element.set_focus_mode(0 if value else 2)


func set_value_no_signal(value) -> void:
	match ui_element.get_class():
		"CheckBox", "CheckButton":
			ui_element.set_pressed_no_signal(value)
		"OptionButton":
			ui_element.selected = value
		"HSlider":
			ui_element.set_value_no_signal(value)


func update() -> void:
	if mockup:
		return
	if is_instance_valid(ui_element):
		var singleton = get_singleton()
		set_value_no_signal(singleton[attribute_name])
		if poll != "":
			var poll_result = false
			if singleton.has_method(poll):
				poll_result = singleton.call(poll)
			if poll_result:
				disable_ui_element(false)
			else:
				disable_ui_element(true)
