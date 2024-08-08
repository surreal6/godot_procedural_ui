extends UIAttributeResource
class_name UIBoolAttributeResource

@export var value : bool = false

func get_ui_element():
	var hbox = HBoxContainer.new()
	var label = Label.new()
	label.text = label_text
	hbox.add_child(label)
	var checkbox = CheckBox.new()
	checkbox.visibility_changed.connect(_update)
	checkbox.toggled.connect(func(toggled_on): self._on_set_attribute_value(toggled_on))
	checkbox.mouse_entered.connect(_register_as_last_focused)
	checkbox.mouse_exited.connect(_unregister_as_last_focused)
	hbox.add_child(checkbox)
	ui_element = checkbox
	return hbox

func _update():
	var singleton = UIManager.get_tree().root.get_node(object_name)
	ui_element.set_pressed_no_signal(singleton[attribute_name])
