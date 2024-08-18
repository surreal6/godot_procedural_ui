extends UIAttributeResource
class_name UIOptionsAttributeResource

@export var options : Array[String] = []
@export var value : int = -1
@export var options_tts_files : Array[String] = []

func get_ui_element():
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
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
	var option_button = OptionButton.new()
	if tooltip:
		option_button.tooltip_text = tooltip
	for option in options:
		option_button.add_item(option)
	option_button.visibility_changed.connect(update)
	option_button.item_selected.connect(func(index): self._on_set_attribute_value(index))
	option_button.mouse_entered.connect(_register_as_last_focused)
	option_button.mouse_exited.connect(_unregister_as_last_focused)
	option_button.focus_entered.connect(_register_as_last_focused)
	option_button.focus_exited.connect(_unregister_as_last_focused)
	option_button.item_focused.connect(func(index): self._register_as_item_focused(index))
	#option_button.gui_input.connect(func(event): print(event))
	cc2.add_child(option_button)
	ui_element = option_button
	return hbox


func update() -> void:
	if is_instance_valid(ui_element):
		var singleton = UIManager.get_tree().root.get_node(object_name)
		var current_value = singleton[attribute_name]
		ui_element.selected = current_value
		

func _on_set_attribute_value(new_value) -> void:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	singleton[attribute_name] = new_value
	if options_tts_files and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(options_tts_files[new_value])
		if UIManager.ui_data.basic_tts_files:
			UIManager.tts_player.finished.connect(play_tts_selected)
		UIManager.tts_player.play()
	singleton.save()
	UIManager.update_sections()


func _register_as_last_focused() -> void:
	UIManager.last_ui_element_focused = ui_element
	#print("register %s" % ui_element.name)
	if tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		if UIManager.ui_data.basic_tts_files:
			UIManager.tts_player.finished.connect(play_tts_selected_item)
		UIManager.tts_player.play()


func play_tts_selected_item():
	if value > -1:
		UIManager.tts_player.stream = load(options_tts_files[value])
		UIManager.tts_player.finished.disconnect(play_tts_selected_item)
		UIManager.tts_player.play()


func play_tts_selected():
	UIManager.tts_player.stream = load(UIManager.ui_data.basic_tts_files.selected)
	UIManager.tts_player.finished.disconnect(play_tts_selected)
	UIManager.tts_player.play()


func _register_as_item_focused(index) -> void:
	UIManager.last_ui_element_focused = ui_element.name + "_" + str(index)
	#print("register %s" % UIManager.last_ui_element_focused)
	if options_tts_files and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(options_tts_files[index])
		UIManager.tts_player.play()
