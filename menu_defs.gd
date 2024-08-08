extends Node



var ui_attr_data = {
	"play_area_mode" : {
		"object" : "UserSettings",
		"type" : "options",
		"label" : "play area mode",
		"options" : "PlayAreaMode",
	},
	"passthrough" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "passthrough",
	},
	"gaze_selection" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "gaze selection",
	},
	"visuals" : {
		"object" : "UserSettings",
		"type" : "bool",
		"label" : "visuals",
	},
	"color_palette" : {
		"object" : "UserSettings",
		"type" : "options",
		"label" : "color palette",
		"options" : "ColorPalette",
	},
	"emitters_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "emitters volume",
		"min" : 0,
		"max" : 100,
	},
	"fx_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "fx volume",
		"min" : 0,
		"max" : 100,
	},
	"music_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "music volume",
		"min" : 0,
		"max" : 100,
	},
	"voice_over_volume" : {
		"object" : "UserSettings",
		"type" : "int",
		"label" : "voice over volume",
		"min" : 0,
		"max" : 100,
	},
}
