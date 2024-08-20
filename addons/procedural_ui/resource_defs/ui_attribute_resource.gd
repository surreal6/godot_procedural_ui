extends Resource
class_name UIAttributeResource

@export var label_text : String = ""
@export var tooltip : String = ""
@export var object_name : String = ""
@export var attribute_name : String = ""
@export var tts_file : String = ""
@export var visibility_poll : String = ""

var ui_element : Control
var ui_container : Control

func _on_set_attribute_value(new_value) -> void:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	singleton[attribute_name] = new_value
	singleton.save()
	UIManager.update_sections()


func _register_as_last_focused() -> void:
	UIManager.last_ui_element_focused = ui_element
	#print("register %s" % ui_element.name)
	if tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		UIManager.tts_player.play()


func _unregister_as_last_focused() -> void:
	UIManager.last_ui_element_focused = null
	#print("unregister %s" % ui_element.name)
	if tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()


func is_visible():
	if visibility_poll != "":
		var singleton = UIManager.get_tree().root.get_node(object_name)
		var poll_result = singleton.call(visibility_poll)
		return poll_result
	return true
