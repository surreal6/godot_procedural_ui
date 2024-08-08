@tool
extends EditorPlugin


const UI_MANAGER = "UIManager"


func _enter_tree() -> void:
	add_autoload_singleton(UI_MANAGER, "res://addons/procedural_ui/ui_manager.gd")


func _exit_tree() -> void:
	remove_autoload_singleton(UI_MANAGER)
