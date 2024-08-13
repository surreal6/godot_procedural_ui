extends UIAttributeResource
class_name UIOperatorAttributeResource

@export var poll : String = ""
@export var disabled : bool = false

func get_ui_element():
	var cc1 = CenterContainer.new()
	cc1.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var button = Button.new()
	button.text = label_text
	if tooltip:
		button.tooltip_text = tooltip
	button.visibility_changed.connect(update)
	button.pressed.connect(func(): self._on_pressed())
	button.mouse_entered.connect(_register_as_last_focused)
	button.mouse_exited.connect(_unregister_as_last_focused)
	cc1.add_child(button)
	ui_element = button
	return cc1


func _on_pressed():
	print("button pressed")
	var singleton = UIManager.get_tree().root.get_node(object_name)
	singleton.call(attribute_name)


func update():
	print("button update")
	if poll != "":
		var singleton = UIManager.get_tree().root.get_node(object_name)
		var poll_result = singleton.call(poll)
		if poll_result:
			ui_element.disabled = false
		else:
			ui_element.disabled = true