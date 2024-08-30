class_name UIAttributeResource
extends UIResource

@export var attribute_name : String = ""
@export var label_text : String = ""
@export var tooltip : String = ""
@export var tts_file : String = ""

@export var stretch_ratio : float = 1


func _on_set_attribute_value(new_value) -> void:
	var singleton = UIManager.get_tree().root.get_node(object_name)
	singleton[attribute_name] = new_value
	singleton.save()
	UIManager.update_sections()


func _register_as_last_focused() -> void:
	UIManager.new_focused_target = ui_element
	#print("register focus %s" % ui_element.name)
	play_tts_attribute()


func _unregister_as_last_focused() -> void:
	UIManager.new_focused_target = null
	#print("unregister focus %s" % ui_element.name)
	stop_tts()


func _register_as_last_hovered() -> void:
	UIManager.new_hovered_target = ui_element
	#print("register hover %s" % ui_element.name)
	play_tts_attribute()


func _unregister_as_last_hovered() -> void:
	UIManager.new_hovered_target = null
	#print("unregister hover %s" % ui_element.name)
	stop_tts()


# func is_visible() -> bool:
# 	if visibility_poll != "":
# 		var singleton = UIManager.get_tree().root.get_node(object_name)
# 		var poll_result = singleton.call(visibility_poll)
# 		return poll_result
# 	return true

func play_tts_attribute() -> void:
	if UIManager.enable_text_to_speech and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
		UIManager.tts_player.stream = load(tts_file)
		UIManager.tts_player.play()


func stop_tts() -> void:
	if UIManager.enable_text_to_speech and tts_file and is_instance_valid(UIManager.tts_player):
		if UIManager.tts_player.playing:
			UIManager.tts_player.stop()
