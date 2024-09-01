class_name UIIntAttributeResource
extends UIAttributeResource

@export var value : int = 0.0

# slider attributes
@export var tick_count : int = 0
@export var ticks_on_borders : bool = false
@export var min : int = 0
@export var max : int = 100
@export var step : float = 1

# other options
@export var use_slider : bool = false
@export var unit_label : String = ""

var label_value = Label


func _init(data) -> void:
	super(data)
	min = data.min
	max = data.max
	step = data.step if "step" in data.keys() else 0.01
	tick_count = data.tick_count if "tick_count" in data.keys() else 0
	ticks_on_borders = data.ticks_on_borders if "ticks_on_borders" in data.keys() else false
	value = get_attribute_value()


func get_custom_class() -> String:
	return "UIIntAttributeResource"


func get_ui_element():
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var cc1 = CenterContainer.new()
	cc1.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(cc1)
	var hbox_unit = HBoxContainer.new()
	hbox_unit.alignment = BoxContainer.ALIGNMENT_CENTER
	hbox_unit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(hbox_unit)
	var label = Label.new()
	label.text = label_text
	if tooltip:
		label.tooltip_text = tooltip
	cc1.add_child(label)
	var slider = HSlider.new()
	if tooltip:
		slider.tooltip_text = tooltip
	slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slider.size_flags_vertical = Control.SIZE_EXPAND_FILL
	slider.min_value = min
	slider.max_value = max
	slider.step = step
	slider.tick_count = tick_count
	slider.ticks_on_borders = ticks_on_borders
	slider.visibility_changed.connect(update)
	slider.value_changed.connect(func(new_value): 
		self._on_set_attribute_value(new_value)
		label_value.text = str(new_value) + unit_label)
	slider.mouse_entered.connect(_register_as_last_hovered)
	slider.mouse_exited.connect(_unregister_as_last_hovered)
	slider.focus_entered.connect(_register_as_last_focused)
	slider.focus_exited.connect(_unregister_as_last_focused)
	hbox_unit.add_child(slider)
	var cc2 = CenterContainer.new()
	cc2.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	cc2.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	cc2.size_flags_stretch_ratio = 0.25
	hbox_unit.add_child(cc2)
	label_value = Label.new()
	label_value.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label_value.size_flags_stretch_ratio = 0.25
	label_value.text = str(value) + unit_label
	cc2.add_child(label_value)
	ui_element = slider
	hbox.size_flags_stretch_ratio = stretch_ratio
	ui_container = hbox
	return hbox

func update():
	super()
	if mockup:
		return
	if is_instance_valid(ui_element):
		var singleton = get_singleton()
		label_value.text = str(singleton[attribute_name]) + unit_label
