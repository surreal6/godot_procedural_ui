extends Node

signal current_section_selected(section_name)

var last_ui_element_focused = null
var sections_array : Array[UISectionResource] = []
var last_section_focused = null

@export var sections_container : Control :set = set_sections_container
@export var current_section_container : Control :set = set_current_section_container

@export var main_theme : Theme :set = set_main_theme


func set_sections_container(new_value):
	sections_container = new_value


func set_current_section_container(new_value):
	current_section_container = new_value


func set_main_theme(new_value):
	main_theme = new_value


func populate_sections_selector():
	for child in sections_container.get_children():
		sections_container.remove_child(child)
		child.queue_free()
	if is_instance_valid(main_theme):
		sections_container.theme = main_theme
	sections_container.add_child(Panel.new())
	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	for section in sections_array:
		var button = section.get_ui_element()
		if section.theme:
				button.theme = section.theme
		vbox.add_child(button)
	sections_container.add_child(vbox)
	sections_selector_grab_focus()


func sections_selector_grab_focus():
	if last_section_focused:
		for section in sections_array:
			if section.section_name == last_section_focused:
				var index = sections_array.find(section)
				sections_container.get_children()[1].get_children()[index].call_deferred("grab_focus")
	else:
		sections_container.get_children()[1].get_children()[0].call_deferred("grab_focus")


func populate_sections_selector_back():
	for child in sections_container.get_children():
		sections_container.remove_child(child)
		child.queue_free()
	var button = Button.new()
	button.text = "< BACK"
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.pressed.connect(func():
		populate_sections_selector()
		current_section_selected.emit("")
		)
	sections_container.add_child(button)


func populate_current_section(current_section):
	last_section_focused = current_section
	for child in current_section_container.get_children():
		child.queue_free()
	for section in sections_array:
		if section.section_name == current_section:
			var section_element = section.get_ui_section_element()
			if section.theme:
				current_section_container.theme = section.theme
			current_section_container.add_child(Panel.new())
			current_section_container.add_child(section_element)
			# TODO 
			# fix grab focus (add function to each attr resource)
			section.grab_focus()
			populate_sections_selector_back()
			current_section_selected.emit(current_section)


func generate_sections_resources(data):
	for section in data:
		generate_section_resource(data[section], section)


func generate_section_resource(section, section_name):
	var resource = UISectionResource.new()
	resource.section_name = section_name
	resource.label_text = section.label
	resource.elements_data = section.data
	resource.theme = section.theme
	sections_array.append(resource)
	return resource


func update_sections():
	for section in sections_array:
		section.update_section()
