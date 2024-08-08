extends Control


func _ready() -> void:
	var resource = generate_section_resource()
	var section = resource.get_ui_section_element()
	add_child(section)

func generate_section_resource():
	var resource = UISectionResource.new()
	resource.label_text = "seccion test"
	resource.object_name = "UserSettings"
	resource.elements_data_name = "ui_data"
	return resource
