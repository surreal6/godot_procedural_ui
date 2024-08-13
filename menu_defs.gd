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
	},
	"passthrough" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "passthrough",
		"checkbutton" : true,
		"tooltip" : "This is the passthrough tooltip",
	},
	"operator_1" : {
		"object" : "UserSettings",
		"type" : "operator",
		"label" : "operator one",
		"tooltip" : "This is the operator_1 tooltip",
	},
	"operator_2" : {
		"object" : "UserSettings",
		"poll" : "operator_2_poll",
		"type" : "operator",
		"label" : "operator two",
		"tooltip" : "Operator 2 only available if gaze_selection is active",
	},
}

var ui_section_accesibility = {
	"gaze_selection" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "gaze selection",
		"tooltip" : "This is the gaze_selection tooltip",
	},
	"visuals" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "visuals",
		"tooltip" : "This is the visuals tooltip",
	},
	"color_palette" : {
		"object" : "UserSettings",
		"type" : "options",
		"label" : "color palette",
		"options" : "ColorPalette",
		"tooltip" : "This is the color_palette tooltip",
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
	},
	"fx_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "fx volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the fx_volume tooltip",
	},
	"music_volume" : {
		"object" : "UserSettings",
		"type" : "float",
		"label" : "music volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the music_volume tooltip",
	},
	"voice_over_volume" : {
		"object" : "UserSettings",
		"type" : "float",
		"label" : "voice over volume",
		"min" : 0,
		"max" : 100,
		"tooltip" : "This is the voice_over_volume tooltip",
	},
}


var ui_data = {
	"ui_section_vr" : {
		"label" : "VR settings",
		"theme" : KENNEY_UI_RED,
		"data" : ui_section_vr,
	},
	"ui_section_accesibility" : {
		"label" : "Accesibility",
		"theme" : KENNEY_UI_YELLOW,
		"data" : ui_section_accesibility,
	},
	"ui_section_audio" : {
		"label" : "Audio",
		"theme" : KENNEY_UI_GREEN,
		"data" : ui_section_audio,
	},
}

var ui_main_theme = KENNEY_UI
