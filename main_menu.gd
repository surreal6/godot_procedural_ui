extends Control


@onready var p1_contanier = $panel_1_container
@onready var p2_contanier = $panel_2_container


@export var root_menu_active : bool = true: set = set_root_menu_active


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
	p1_contanier.position.x = 540
	p1_contanier.size.x = 840
	#p1_contanier.theme_override_constants.margin_right = 

func set_panel1_inactive() -> void:
	#p1_contanier.position.x = -420
	p1_contanier.position.x = 0
	p1_contanier.size.x = 420
	#p1_contanier.theme_override_constants.margin_right = 0


func set_panel2_active() -> void:
	p2_contanier.position.x = 420
	p2_contanier.show()


func set_panel2_inactive() -> void:
	p2_contanier.position.x = 1380
	p2_contanier.hide()


func _ready() -> void:
	UIManager.current_section_selected.connect(_on_section_selected)
	UIManager.generate_sections_resources(UserSettings.ui_data)
	UIManager.set_sections_container(p1_contanier)
	UIManager.set_current_section_container(p2_contanier)
	if UserSettings.ui_main_theme:
		UIManager.set_main_theme(UserSettings.ui_main_theme)
	UIManager.populate_sections_selector()
	update_menus()


func _on_section_selected(section_name):
	if section_name:
		root_menu_active = false
	else:
		root_menu_active = true

#
#func _input(event):
	#if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_left"):
		#if root_menu_active:
			#hide()
		#else:
			#root_menu_active = true
			#UIManager.populate_sections_selector()
	#if event.is_action_pressed("ui_select"):
		#if !visible:
			#show()
			#UIManager.sections_selector_grab_focus()
			

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_left"):
		if root_menu_active:
			hide()
		else:
			root_menu_active = true
			UIManager.populate_sections_selector()
	if Input.is_action_just_pressed("ui_select"):
		if !visible:
			show()
			UIManager.sections_selector_grab_focus()
