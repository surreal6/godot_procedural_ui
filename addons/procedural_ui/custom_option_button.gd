# Based on hover detection for ItemList by ForkedStill
extends OptionButton
class_name CustomOptionButton

signal item_hovered(index : int)

# Boundaries of the popup menu
var popup_rect : Rect2
# Height of one menu item
var item_height : int
# Index of the currently hovered item
var hovered_item : int = -1

# Connect popup signals
func _ready() -> void:
	get_popup().mouse_entered.connect(hover_setup)
	get_popup().window_input.connect(hover_detect)
	get_popup().mouse_exited.connect(hover_clear)

# Setup all measurements on mouse enter, assuming they don't change while the popup is open
func hover_setup() -> void:
	#print("Mouse entered the popup menu")
	popup_rect = Rect2(get_popup().position, get_popup().size)
	# This only takes item sizes into account. Might need tweaking for separators and margins
	item_height = popup_rect.size.y / get_popup().item_count

# Called when mouse is moving within the list
func hover_detect(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_pos := get_local_mouse_position()
		# Perhaps a redundant check?
		if popup_rect.has_point(get_global_mouse_position()):
			var index : int = int(mouse_pos.y) / item_height - 1
			if hovered_item != index:
				if index in range(get_popup().item_count):
					item_hovered.emit(index)
					#print("Hovered item %s" % index)
				hovered_item = index

# Called when mouse leaves the list
func hover_clear() -> void:
	#print("Mouse left the popup menu")
	hovered_item = -1
