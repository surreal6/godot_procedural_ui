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

var ui_attr_data = {
	"play_area_mode" : {
		"type" : "options",
		"label" : "play area mode",
		"options" : PlayAreaMode,
	},
	"passthrough" : {
		"type" : "bool",
		"label" : "passthrough",
	},
	"gaze_selection" : {
		"type" : "bool",
		"label" : "gaze selection",
	},
	"visuals" : {
		"type" : "bool",
		"label" : "visuals",
	},
	"color_palette" : {
		"type" : "options",
		"label" : "color palette",
		"options" : ColorPalette,
	},
	"emitters_volume" : {
		"type" : "int",
		"label" : "emitters volume",
		"min" : 0,
		"max" : 100,
	},
	"fx_volume" : {
		"type" : "int",
		"label" : "fx volume",
		"min" : 0,
		"max" : 100,
	},
	"music_volume" : {
		"type" : "int",
		"label" : "music volume",
		"min" : 0,
		"max" : 100,
	},
	"voice_over_volume" : {
		"type" : "int",
		"label" : "voice over volume",
		"min" : 0,
		"max" : 100,
	},
}

var last_ui_element_focused = null
