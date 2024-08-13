extends Node

const KENNEY_UI_BLUE = preload("res://kenney_themes/kenneyUI-blue.tres")
const KENNEY_UI_GREEN = preload("res://kenney_themes/kenneyUI-green.tres")
const KENNEY_UI_RED = preload("res://kenney_themes/kenneyUI-red.tres")
const KENNEY_UI_YELLOW = preload("res://kenney_themes/kenneyUI-yellow.tres")
const KENNEY_UI = preload("res://kenney_themes/kenneyUI.tres")


var ui_section_vr = {
	"play_area_mode" : {
		"object" : "UserSettings",
		"type" : "options",
		"label" : "play area mode",
		"options" : "PlayAreaMode",
		"tooltip" : "This is the play_area_mode tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_play_area_mode_selector.mp3",
		"options_tts_files" : [
			"res://menu_tts_files/loc_en_roomscale.mp3",
			"res://menu_tts_files/loc_en_standing.mp3"
		]
	},
	"passthrough" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "passthrough",
		"checkbutton" : true,
		"tooltip" : "This is the passthrough tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_passthrough_checkbox.mp3",
	},
	"operator_1" : {
		"object" : "UserSettings",
		"type" : "operator",
		"label" : "operator one",
		"tooltip" : "This is the operator_1 tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_operator_one_button.mp3",
	},
	"operator_2" : {
		"object" : "UserSettings",
		"poll" : "operator_2_poll",
		"type" : "operator",
		"label" : "operator two",
		"tooltip" : "Operator 2 only available if gaze_selection is active",
		"tts_file" : "res://menu_tts_files/loc_en_operator_two_button.mp3",
	},
}

var ui_section_accesibility = {
	"gaze_selection" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "gaze selection",
		"tooltip" : "This is the gaze_selection tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_gaze_selection_checkbox.mp3",
	},
	"visuals" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "visuals",
		"tooltip" : "This is the visuals tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_visuals_checkbox.mp3",
	},
	"color_palette" : {
		"object" : "UserSettings",
		"type" : "options",
		"label" : "color palette",
		"options" : "ColorPalette",
		"tooltip" : "This is the color_palette tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_color_palette_selector.mp3",
		"options_tts_files" : [
			"res://menu_tts_files/loc_en_A.mp3",
			"res://menu_tts_files/loc_en_B.mp3",
			"res://menu_tts_files/loc_en_C.mp3",
		]
	},
}

var ui_section_audio =  {
	"emitters_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "emitters volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the emitters_volume tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_emitters_volume_slider.mp3",
	},
	"fx_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "fx volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the fx_volume tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_effects_volume_slider.mp3",
	},
	"music_volume" : {
		"object" : "UserSettings",
		"type" : "float",
		"label" : "music volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the music_volume tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_music_volume_slider.mp3",
	},
	"voice_over_volume" : {
		"object" : "UserSettings",
		"type" : "float",
		"label" : "voice over volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the voice_over_volume tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_voice_over_volume_slider.mp3",
	},
}

var ui_back_button_section = {
	"back_button" : {
		"object" : "UIManager",
		"type" : "operator",
		"label" : "Back",
		"tooltip" : "This is the back button tooltip",
		"tts_file" : "res://menu_tts_files/loc_en_back.mp3",
	},
}


var ui_data = {
	"ui_section_vr" : {
		"label" : "VR settings",
		"theme" : KENNEY_UI_RED,
		"data" : ui_section_vr,
		"tts_file" : "res://menu_tts_files/loc_en_virtual_reality_settings_section.mp3",
	},
	"ui_section_accesibility" : {
		"label" : "Accesibility",
		"theme" : KENNEY_UI_YELLOW,
		"data" : ui_section_accesibility,
		"tts_file" : "res://menu_tts_files/loc_en_accesibility_settings_section.mp3",
	},
	"ui_section_audio" : {
		"label" : "Audio",
		"theme" : KENNEY_UI_GREEN,
		"data" : ui_section_audio,
		"tts_file" : "res://menu_tts_files/loc_en_audio_settings_section.mp3",
	},
}

var ui_main_theme = KENNEY_UI
