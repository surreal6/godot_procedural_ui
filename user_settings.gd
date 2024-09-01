extends Node


enum PlayAreaMode {
	ROOMSCALE,
	STANDING,
}

enum ColorPalette {
	A,
	B,
	C,
}

const MENU_DEFS = preload("res://menu_defs.gd")

var play_area_mode : PlayAreaMode = PlayAreaMode.ROOMSCALE
var passthrough : bool = false
var hover_click : bool = true:
	set(value):
		hover_click = value
		UIManager.enable_hover_click = value
var hover_click_hold_time : float = 2.0:
	set(value):
		hover_click_hold_time = value
		UIManager.hover_click_hold_time = hover_click_hold_time
var text_to_speech : bool = true:
	set(value):
		text_to_speech = value
		UIManager.enable_text_to_speech = value
var visuals : bool = true
var color_palette : ColorPalette = ColorPalette.A
var emitters_volume : float = 50
var mute_emitters : bool = false
var fx_volume : float = 50
var mute_fx : bool = false
var music_volume : float = 50
var mute_music : bool = false
var voice_over_volume : float = 50
var mute_voice_over : bool = false



## Settings file name to persist user settings
var settings_file_name : String = "user://user_settings.json"


# to store menu definitions
var ui_data : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	_load()
	get_ui_data()


func get_ui_data():
	var menu_defs = MENU_DEFS.new()
	ui_data = menu_defs.ui_data


## Reset to default values
func reset_to_defaults() -> void:
	# Reset to defaults.
	play_area_mode = PlayAreaMode.ROOMSCALE
	passthrough = false
	hover_click = true
	hover_click_hold_time = 2
	text_to_speech = true
	visuals = true
	color_palette = ColorPalette.A
	emitters_volume = 50
	mute_emitters = false
	fx_volume = 50
	mute_fx = false
	music_volume = 50
	mute_music = false
	voice_over_volume = 50
	mute_voice_over = false


## Save the settings to file
func save() -> void:
	# Convert the settings to a dictionary
	var settings := {
		"options" : {
			"play_area_mode" : play_area_mode,
			"passthrough" : passthrough,
			"hover_click" : hover_click,
			"hover_click_hold_time" : hover_click_hold_time,
			"text_to_speech" : text_to_speech,
			"visuals" : visuals,
			"color_palette" : color_palette,
			"emitters_volume" : emitters_volume,
			"fx_volume" : fx_volume,
			"music_volume" : music_volume,
			"voice_over_volume" : voice_over_volume,
			"mute_emitters" : mute_emitters,
			"mute_fx" : mute_fx,
			"mute_music" : mute_music,
			"mute_voice_over" : mute_voice_over,
		}
	}

	# Convert the settings dictionary to text
	var settings_text := JSON.stringify(settings)

	# Attempt to open the settings file for writing
	var file := FileAccess.open(settings_file_name, FileAccess.WRITE)
	if not file:
		push_warning("Unable to write to %s" % settings_file_name)
		return

	# Write the settings text to the file
	file.store_line(settings_text)
	file.close()


## Load the settings from file
func _load() -> void:
	# First reset our values
	reset_to_defaults()

	# Skip if no settings file found
	if !FileAccess.file_exists(settings_file_name):
		return

	# Attempt to open the settings file for reading
	var file := FileAccess.open(settings_file_name, FileAccess.READ)
	if not file:
		push_warning("Unable to read from %s" % settings_file_name)
		return

	# Read the settings text
	var settings_text := file.get_as_text()
	file.close()

	# Parse the settings text and verify it's a dictionary
	var settings_raw = JSON.parse_string(settings_text)
	if typeof(settings_raw) != TYPE_DICTIONARY:
		push_warning("Settings file %s is corrupt" % settings_file_name)
		return

	# Parse our input settings
	var settings : Dictionary = settings_raw

	# Parse our Options settings
	if settings.has("options"):
		var options : Dictionary = settings["options"]
		if options.has("play_area_mode"):
			play_area_mode = options["play_area_mode"]
		if options.has("passthrough"):
			passthrough = options["passthrough"]
		if options.has("hover_click"):
			hover_click = options["hover_click"]
		if options.has("hover_click_hold_time"):
			hover_click_hold_time = options["hover_click_hold_time"]
		if options.has("text_to_speech"):
			text_to_speech = options["text_to_speech"]
		if options.has("visuals"):
			visuals = options["visuals"]
		if options.has("color_palette"):
			color_palette = options["color_palette"]
		if options.has("emitters_volume"):
			emitters_volume = options["emitters_volume"]
		if options.has("fx_volume"):
			fx_volume = options["fx_volume"]
		if options.has("music_volume"):
			music_volume = options["music_volume"]
		if options.has("voice_over_volume"):
			voice_over_volume = options["voice_over_volume"]
		if options.has("mute_emitters"):
			mute_emitters = options["mute_emitters"]
		if options.has("mute_fx"):
			mute_fx = options["mute_fx"]
		if options.has("mute_music"):
			mute_music = options["mute_music"]
		if options.has("mute_voice_over"):
			mute_voice_over = options["mute_voice_over"]


func hold_time_visibility_poll():
	return hover_click


func passthrough_visibility_poll():
	if play_area_mode == 0:
		return true
	return false


func operator_1():
	print("operator 1 executed")


func operator_2():
	print("operator 2 executed")


func operator_2_poll():
	return hover_click


func is_xr_mode_standing():
	return play_area_mode == PlayAreaMode.STANDING


func is_xr_mode_roomscale():
	return play_area_mode == PlayAreaMode.ROOMSCALE
