extends Node

var last_ui_element_focused = null

var sections_array : Array[UISectionResource] = []

func update_sections():
	for section in sections_array:
		section.update_section()
