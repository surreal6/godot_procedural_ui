extends Control


@onready var p1_contanier = $panel_1_container
@onready var p2_contanier = $panel_2_container
@onready var cursor_canvas_layer: CanvasLayer = $CursorCanvasLayer


@export var root_menu_active : bool = true: set = set_root_menu_active



func _ready() -> void:
	UIManager.cursor_canvas_layer = cursor_canvas_layer
	UIManager.set_ui_data(UserSettings.ui_data)
	UIManager.set_sections_container(p1_contanier)
	UIManager.set_current_section_container(p2_contanier)
	UIManager.set_tts_player($AudioStreamPlayer)
	UIManager.current_section_selected.connect(_on_section_selected)
	UIManager.populate_sections_selector()
	
	update_menus()
	p1_contanier.position.x = 540
	p1_contanier.size.x = 840


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if root_menu_active:
			hide()
		else:
			root_menu_active = true
			UIManager.populate_sections_selector()
	if Input.is_action_just_pressed("ui_select"):
		if !visible:
			show()
			UIManager.sections_selector_grab_focus()




func _on_section_selected(section_name):
	if section_name:
		root_menu_active = false
	else:
		root_menu_active = true


func set_root_menu_active(new_value) -> void:
	root_menu_active = new_value
	if is_visible_in_tree():
		update_menus()


func update_menus() -> void:
	if root_menu_active:
		set_panel1_active()
		set_panel2_inactive()
	else:
		set_panel1_inactive()
		set_panel2_active()


func set_panel1_active() -> void:
	var tween_p1 = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween_p1.tween_property(p1_contanier, "position:x", 540, 0.75)
	var tween_p2 = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween_p2.tween_property(p1_contanier, "size:x", 840, 0.75)
	#p1_contanier.position.x = 540
	#p1_contanier.size.x = 840

func set_panel1_inactive() -> void:
	var tween_p1 = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween_p1.tween_property(p1_contanier, "position:x", 0, 0.75)
	var tween_p2 = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween_p2.tween_property(p1_contanier, "size:x", 420, 0.75)
	#p1_contanier.position.x = 0
	#p1_contanier.size.x = 420


func set_panel2_active() -> void:
	var tween_p2 = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween_p2.tween_property(p2_contanier, "position:x", 420, 0.75)
	#p2_contanier.position.x = 420
	p2_contanier.show()


func set_panel2_inactive() -> void:
	var tween_p2 = self.create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween_p2.tween_property(p2_contanier, "position:x", 1380, 0.75)
	#p2_contanier.position.x = 1380
	p2_contanier.hide()
