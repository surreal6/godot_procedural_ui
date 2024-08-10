extends Node

var ui_attr_data = {
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


var ui_section_vr = {
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
}

var ui_section_accesibility = {
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
}

var ui_section_audio =  {
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
