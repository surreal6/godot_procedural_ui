class_name UIOptionsAttributeResource
extends UIAttributeResource

@export var options_name : String = ""
@export var options : Array[String] = []
@export var value : int = -1
@export var options_tts_files : Array[String] = []


func _init(data) -> void:
	super(data)
	options_name = data.options
	var options_data = get_options()
	if options_data:
		for option in options_data:
			options.append(option)
		if "options_tts_files" in data.keys():
			for item in data.options_tts_files:
				options_tts_files.append(item)
	value = get_attribute_value()


func get_ui_resource_class() -> String:
	return "UIOptionsAttributeResource"


func get_options():
	var singleton = get_singleton()
	if options_name not in singleton:
		mockup = true
		push_warning("UIManager: options '%s' not found" % options_name)
		push_warning("UIManager: Activate mockup for '%s'" % options_name)
		return null
	return singleton[options_name]

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
	var label = Label.new()
	label.text = label_text
	if tooltip:
		label.tooltip_text = tooltip
	cc1.add_child(label)
	var option_button = CustomOptionButton.new()
	if tooltip:
		option_button.tooltip_text = tooltip
	for option in options:
		option_button.add_item(option)
	option_button.visibility_changed.connect(update)
	option_button.item_selected.connect(func(index): self._on_set_attribute_value(index))
	option_button.mouse_entered.connect(_register_as_last_hovered)
	option_button.mouse_exited.connect(_unregister_as_last_hovered)
	option_button.focus_entered.connect(_register_as_last_focused)
	option_button.focus_exited.connect(_unregister_as_last_focused)
	option_button.item_focused.connect(func(index): self._register_as_item_focused(index))
	option_button.item_hovered.connect(func(index): self._register_as_item_hovered(index))
	cc2.add_child(option_button)
	ui_element = option_button
	hbox.size_flags_stretch_ratio = stretch_ratio
	ui_container = hbox
	return hbox


func _on_set_attribute_value(new_value) -> void:
	if mockup:
		return
	var singleton = get_singleton()
	singleton[attribute_name] = new_value
	value = new_value
	if (UIManager.enable_text_to_speech and options_tts_files
		and is_instance_valid(UIManager.tts_player)):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(options_tts_files[new_value])
		if UIManager.ui_data.basic_tts_files:
			for item in UIManager.tts_player.finished.get_connections():
				UIManager.tts_player.finished.disconnect(item.callable)
			UIManager.tts_player.finished.connect(play_tts_selected)
		UIManager.tts_player.play()
	singleton.save()
	UIManager.update_sections()


func _register_as_last_focused() -> void:
	UIManager.new_focused_target = ui_element
	#print("register %s" % ui_element.name)
	if UIManager.enable_text_to_speech and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		if UIManager.ui_data.basic_tts_files:
			for item in UIManager.tts_player.finished.get_connections():
				UIManager.tts_player.finished.disconnect(item.callable)
			UIManager.tts_player.finished.connect(play_tts_selected_item)
		UIManager.tts_player.play()


func _register_as_item_focused(index) -> void:
	UIManager.new_focused_target = ui_element
	UIManager.new_hovered_item = index
	#print("register %s" % UIManager.new_focused_target)
	play_tts_option(index)


func _register_as_item_hovered(index) -> void:
	if index == -1:
		UIManager.new_hovered_target = null
	else:
		UIManager.new_hovered_target = ui_element

	UIManager.new_hovered_item = index
	#print("register %s" % UIManager.new_focused_target)
	play_tts_option(index)


func play_tts_selected_item():
	for item in UIManager.tts_player.finished.get_connections():
		UIManager.tts_player.finished.disconnect(item.callable)
	if value > -1:
		UIManager.tts_player.stream = load(options_tts_files[value])
		UIManager.tts_player.play()


func play_tts_selected():
	for item in UIManager.tts_player.finished.get_connections():
		UIManager.tts_player.finished.disconnect(item.callable)
	UIManager.tts_player.stream = load(UIManager.ui_data.basic_tts_files.selected)
	UIManager.tts_player.play()


func play_tts_option(index):
	if (UIManager.enable_text_to_speech and options_tts_files
		and is_instance_valid(UIManager.tts_player)):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(options_tts_files[index])
		UIManager.tts_player.play()
