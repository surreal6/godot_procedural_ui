extends CanvasLayer

signal click_detected

@onready var cursor: ColorRect = $Cursor

func _ready() -> void:
	set_layer(1025)

#
#func _input(event):
	#if event is InputEventMouseMotion:
		## Move our cursor
		#var mouse_motion : InputEventMouseMotion = event
		#cursor.position = mouse_motion.position - Vector2(64, 64)


func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	cursor.position = mouse_pos - Vector2(64, 64)




 #CLICK DETECTOR FOR DEBUG PURPOSES
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("I've been clicked %s" % event.position)
			click_detected.emit()
