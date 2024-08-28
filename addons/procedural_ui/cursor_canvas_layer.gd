extends CanvasLayer

signal click_detected

@onready var cursor: ColorRect = $Cursor

func _ready() -> void:
	# to draw the cursor over popup windows
	set_layer(1025)


func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	cursor.position = mouse_pos - Vector2(64, 64)


# emit a click event for ui_manager to stop cursor progress bar.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			click_detected.emit()
