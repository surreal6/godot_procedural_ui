class_name UIOperatorAttributeResource
extends UIAttributeResource

@export var poll : String = ""
@export var disabled : bool = false

func get_ui_element():
	var cc1 = CenterContainer.new()
	cc1.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var button = Button.new()
	button.text = label_text
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	if tooltip:
		button.tooltip_text = tooltip
	button.visibility_changed.connect(update)
	button.pressed.connect(func(): self._on_pressed())
	button.mouse_entered.connect(_register_as_last_hovered)
	button.mouse_exited.connect(_unregister_as_last_hovered)
	button.focus_entered.connect(_register_as_last_focused)
	button.focus_exited.connect(_unregister_as_last_focused)
	cc1.add_child(button)
	ui_element = button
	cc1.size_flags_stretch_ratio = stretch_ratio
	ui_container = cc1
	return cc1


func _on_pressed():
	var singleton = UIManager.get_tree().root.get_node(object_name)
	singleton.call(attribute_name)


func update():
	if is_instance_valid(ui_element):
		if poll != "":
			var singleton = UIManager.get_tree().root.get_node(object_name)
			var poll_result = singleton.call(poll)
			if poll_result:
				ui_element.disabled = false
				ui_element.set_focus_mode(0)
			else:
				ui_element.disabled = true
				ui_element.set_focus_mode(2)
