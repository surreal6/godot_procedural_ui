extends UIAttributeResource
class_name UIBoolAttributeResource

@export var checkbutton : bool = false
@export var value : bool = false

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
	var checkbox
	if checkbutton:
		checkbox = CheckButton.new()
	else:
		checkbox = CheckBox.new()
	checkbox.text = label_text
	if tooltip:
		checkbox.tooltip_text = tooltip
	checkbox.visibility_changed.connect(update)
	checkbox.toggled.connect(func(toggled_on): self._on_set_attribute_value(toggled_on))
	checkbox.mouse_entered.connect(_register_as_last_focused)
	checkbox.mouse_exited.connect(_unregister_as_last_focused)
	cc2.add_child(checkbox)
	ui_element = checkbox
	return hbox

func update():
	if is_instance_valid(ui_element):
		var singleton = UIManager.get_tree().root.get_node(object_name)
		ui_element.set_pressed_no_signal(singleton[attribute_name])
