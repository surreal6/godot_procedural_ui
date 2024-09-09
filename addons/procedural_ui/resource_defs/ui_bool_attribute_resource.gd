class_name UIBoolAttributeResource
extends UIAttributeResource

@export var checkbutton : bool = false
@export var inline_label : bool = false
@export var value : bool = false


func _init(data) -> void:
	super(data)
	inline_label = data.inline_label if "inline_label" in data.keys() else false
	checkbutton = data.checkbutton if "CheckButton" in data.keys() else false
	value = get_attribute_value()

func get_custom_class() -> String:
	return "UIBoolAttributeResource"


func get_ui_element():
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var cc1 = CenterContainer.new()
	cc1.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(cc1)
	var cc2 = CenterContainer.new()
	cc2.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(cc2)
	if !inline_label:
		var label = Label.new()
		label.text = label_text
		if tooltip:
			label.tooltip_text = tooltip
		cc1.add_child(label)
	var checkbox
	if checkbutton:
		checkbox = CheckButton.new()
	else:
		checkbox = CheckBox.new()
	if inline_label:
		checkbox.text = label_text
	if tooltip:
		checkbox.tooltip_text = tooltip
	checkbox.visibility_changed.connect(update)
	checkbox.toggled.connect(func(toggled_on): self._on_set_attribute_value(toggled_on))
	checkbox.mouse_entered.connect(_register_as_last_hovered)
	checkbox.mouse_exited.connect(_unregister_as_last_hovered)
	checkbox.focus_entered.connect(_register_as_last_focused)
	checkbox.focus_exited.connect(_unregister_as_last_focused)
	cc2.add_child(checkbox)
	ui_element = checkbox
	hbox.size_flags_stretch_ratio = stretch_ratio
	ui_container = hbox
	return hbox


func _on_set_attribute_value(new_value) -> void:
	if mockup:
		return
	var singleton = get_singleton()
	singleton[attribute_name] = new_value
	value = new_value
	if (UIManager.enable_text_to_speech and UIManager.ui_data.basic_tts_files
		and is_instance_valid(UIManager.tts_player)):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		var sound = UIManager.ui_data.basic_tts_files.disabled
		if new_value == true:
			sound = UIManager.ui_data.basic_tts_files.enabled
		UIManager.tts_player.stream = load(sound)
		UIManager.tts_player.play()
	singleton.save()
	UIManager.update_sections()


func play_tts_attribute() -> void:
	if UIManager.ui_data.basic_tts_files:
		UIManager.play_tts_on_finished(get_tts_bool_value(value))
	UIManager.play_tts_file(tts_file)


func get_tts_bool_value(value) -> String:
	if value:
		return UIManager.ui_data.basic_tts_files.enabled
	else:
		return UIManager.ui_data.basic_tts_files.disabled
