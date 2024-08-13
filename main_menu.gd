extends Control


func _ready() -> void:
	var resource = generate_section_resource()
	var section : Control = resource.get_ui_section_element()
	add_child(section)
	UIManager.sections_array.append(resource)


func generate_section_resource():
	var resource = UISectionResource.new()
	resource.label_text = "seccion test"
	resource.object_name = "UserSettings"
	resource.elements_data_name = "ui_data"
	return resource


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		hide()
	if event.is_action_pressed("ui_select"):
		show()
