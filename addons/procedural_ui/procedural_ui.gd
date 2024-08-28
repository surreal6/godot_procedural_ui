@tool
extends EditorPlugin

const UI_MANAGER = "UIManager"

func _enter_tree() -> void:
	add_custom_type("CustomOptionButton", "OptionButton",
		preload("custom_option_button.gd"), preload("res://addons/procedural_ui/CustomOptionButton.svg"))
	add_autoload_singleton(UI_MANAGER, "res://addons/procedural_ui/ui_manager.gd")


func _exit_tree() -> void:
	remove_custom_type("CustomOptionButton")
	remove_autoload_singleton(UI_MANAGER)
