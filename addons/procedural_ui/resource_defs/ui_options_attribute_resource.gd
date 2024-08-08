extends UIAttributeResource
class_name UIOptionsAttributeResource

@export var options : Array[String] = []
@export var value : int = -1


func get_ui_element():
	var hbox = HBoxContainer.new()
	var label = Label.new()
	label.text = label_text
	hbox.add_child(label)
	var option_button = OptionButton.new()
	for option in options:
		option_button.add_item(option)
	option_button.visibility_changed.connect(_update)
	option_button.item_selected.connect(func(index): self._on_set_attribute_value(index))
	option_button.mouse_entered.connect(_register_as_last_focused)
	option_button.mouse_exited.connect(_unregister_as_last_focused)
	option_button.item_focused.connect(func(index): self._register_as_item_focused(index))
	hbox.add_child(option_button)
	ui_element = option_button
	return hbox

func _update() -> void:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	var current_value = singleton[attribute_name]
	ui_element.selected = current_value

func _register_as_item_focused(index) -> void:
	UIManager.last_ui_element_focused = ui_element.name + "_" + str(index)
	print("register %s" % UIManager.last_ui_element_focused)
