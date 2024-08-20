extends Node

const MENU_DEFS = preload("res://menu_defs.gd")

enum PlayAreaMode {
	ROOMSCALE,
	STANDING,
}

enum ColorPalette {
	A,
	B,
	C,
}

@export_group("Options")

@export var play_area_mode : PlayAreaMode = PlayAreaMode.ROOMSCALE
@export var passthrough : bool = false
@export var gaze_selection : bool = true
@export var visuals : bool = true
@export var color_palette : ColorPalette = ColorPalette.A
@export var emitters_volume : float = 50
@export var fx_volume : float = 50
@export var music_volume : float = 50
@export var voice_over_volume : float = 50


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
	gaze_selection = true
	visuals = true
	color_palette = ColorPalette.A
	emitters_volume = 50
	fx_volume = 50
	music_volume = 50
	voice_over_volume = 50



## Save the settings to file
func save() -> void:
	# Convert the settings to a dictionary
	var settings := {
		"options" : {
			"play_area_mode" : play_area_mode,
			"passthrough" : passthrough,
			"gaze_selection" : gaze_selection,
			"visuals" : visuals,
			"color_palette" : color_palette,
			"emitters_volume" : emitters_volume,
			"fx_volume" : fx_volume,
			"music_volume" : music_volume,
			"voice_over_volume" : voice_over_volume,
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
		if options.has("gaze_selection"):
			gaze_selection = options["gaze_selection"]
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

func passthrough_visibility_poll():
	if play_area_mode == 0:
		print("passthrough_visibility_poll %s" % true)
		return true
	print("passthrough_visibility_poll %s" % false)
	return false


func operator_1():
	print("operator 1 executed")


func operator_2():
	print("operator 2 executed")


func operator_2_poll():
	return gaze_selection
