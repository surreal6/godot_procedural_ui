extends UIAttributeResource
class_name UIIntAttributeResource

@export var value : int = 0.0

# slider attributes
@export var tick_count : int = 10
@export var ticks_on_borders : bool = true
@export var min : int = 0
@export var max : int = 100
@export var step : float = 1

# other options
@export var use_slider : bool = false
@export var unit_label : String = ""

var label_value = Label

func get_ui_element():
	var hbox = HBoxContainer.new()
	var label = Label.new()
	label.text = label_text
	hbox.add_child(label)
	var slider = HSlider.new()
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.min_value = min
	slider.max_value = max
	slider.step = step
	slider.tick_count = tick_count
	slider.ticks_on_borders = ticks_on_borders
	slider.visibility_changed.connect(_update)
	slider.value_changed.connect(func(new_value): 
		self._on_set_attribute_value(new_value)
		label_value.text = str(new_value) + unit_label)
	slider.mouse_entered.connect(_register_as_last_focused)
	slider.mouse_exited.connect(_unregister_as_last_focused)
	hbox.add_child(slider)
	label_value = Label.new()
	label_value.text = str(value) + unit_label
	hbox.add_child(label_value)
	ui_element = slider
	return hbox

func _update():
	var singleton = UIManager.get_tree().root.get_node(object_name)
	ui_element.set_value_no_signal(singleton[attribute_name])
	label_value.text = str(singleton[attribute_name]) + unit_label
