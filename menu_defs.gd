const KENNEY_UI_BLUE = preload("res://kenney_themes/kenneyUI-blue.tres")
const KENNEY_UI_GREEN = preload("res://kenney_themes/kenneyUI-green.tres")
const KENNEY_UI_RED = preload("res://kenney_themes/kenneyUI-red.tres")
const KENNEY_UI_YELLOW = preload("res://kenney_themes/kenneyUI-yellow.tres")
const KENNEY_UI = preload("res://kenney_themes/kenneyUI.tres")

#
# TTS online generator: https://luvvoice.com/es/
#

var ui_data = {
	"sections" : {
		"level_selection" : {
			"label" : "Level Selection",
			"tts_file" : "",
			"theme" : KENNEY_UI_RED,
			"data" : {
				"level_0" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 0",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_0_poll",
				},
				"level_1" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 1",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_1_poll",
				},
				"level_2" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 2",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_2_poll",
				},
				"level_3" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 3",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_3_poll",
				},
				"level_4" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 4",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_4_poll",
				},
				"level_5" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 5",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_5_poll",
				},
				"level_6" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 6",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_6_poll",
				},
				"level_7" : {
					"object" : "UserSettings",
					"type" : "operator",
					"label" : "Level 7",
					"tooltip" : "This is a level tooltip",
					"tts_file" : "",
					"poll" : "level_7_poll",
				},
			}
		},
		"game_options" : {
			"label" : "Game Options",
			"tts_file" : "",
			"theme" : KENNEY_UI_RED,
			"data" : {
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
				
			}
		},
		"ui_section_vr" : {
			"label" : "VR settings",
			"tts_file" : "res://menu_tts_files/loc_en_virtual_reality_settings_section.mp3",
			"theme" : KENNEY_UI_YELLOW,
			"data" : {
				"passthrough" : {
					"object" : "UserSettings",
					"type" : "bool",
					"label" : "passthrough",
					"checkbutton" : true,
					"tooltip" : "This is the passthrough tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_passthrough_checkbox.mp3",
					"visibility_poll": "passthrough_visibility_poll",
				},
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
				"back_operator" : {
					"object" : "UIManager",
					"type" : "operator",
					"label" : "Back",
					"tooltip" : "This is the back operator tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_back.mp3",
				},
			},
		},
		"ui_section_accesibility" : {
			"label" : "Accesibility",
			"tts_file" : "res://menu_tts_files/loc_en_accesibility_settings_section.mp3",
			"theme" : KENNEY_UI_YELLOW,
			"data" : {
				"hover_click" : {
					"object" : "UserSettings",
					"type" : "bool",
					"label" : "Hover click",
					"tooltip" : "This is the hover_click tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_hover_click_checkbox.mp3",
				},
				"hover_click_hold_time" : {
					"object" : "UserSettings",
					"type" : "float",
					"label" : "hold_time",
					"min" : 1,
					"max" : 10,
					"step" : 1,
					"tick_count": 11,
					"ticks_on_borders" : true,
					"tooltip" : "This is the hover click hold time tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_hover_click_hold_time_slider.mp3",
					"visibility_poll": "hold_time_visibility_poll",
				},
				"text_to_speech" : {
					"object" : "UserSettings",
					"type" : "bool",
					"label" : "text to speech",
					"tooltip" : "This is the text to speech tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_text_to_speech_checkbox.mp3",
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
					"poll" : "color_palette_poll",
					"options_tts_files" : [
						"res://menu_tts_files/loc_en_A.mp3",
						"res://menu_tts_files/loc_en_B.mp3",
						"res://menu_tts_files/loc_en_C.mp3",
					]
				},
				"back_operator" : {
					"object" : "UIManager",
					"type" : "operator",
					"label" : "Back",
					"tooltip" : "This is the back operator tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_back.mp3",
				},
			},
		},
		"ui_section_audio" : {
			"label" : "Audio",
			"tts_file" : "res://menu_tts_files/loc_en_audio_settings_section.mp3",
			"theme" : KENNEY_UI_GREEN,
			"data" : {
					"emitters_line" : {
						"type" : "HBoxContainer",
						"items" : {
							"emitters_volume" : {
								"object" : "UserSettings",
								"type" : "int",
								"label" : "emitters volume",
								"min" : 0,
								"max" : 100,
								"step" : 10,
								"tick_count": 11,
								"ticks_on_borders" : true,
								"tooltip" : "This is the emitters_volume tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_emitters_volume_slider.mp3",
								"stretch_ratio" : 5,
							},
							"mute_emitters" : {
								"object" : "UserSettings",
								"type" : "bool",
								"label" : "mute",
								"inline_label" : true,
								"tooltip" : "This is the mute emitters tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_mute_emitters_checkbox.mp3",
							},
						}	
					},
					"fx_line" : {
						"type" : "HBoxContainer",
						"items" : {
							"fx_volume" : {
								"object" : "UserSettings",
								"type" : "int",
								"label" : "fx volume",
								"min" : 0,
								"max" : 100,
								"step" : 10,
								"tick_count": 11,
								"ticks_on_borders" : true,
								"tooltip" : "This is the fx_volume tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_effects_volume_slider.mp3",
								"stretch_ratio" : 5,
							},
							"mute_fx" : {
								"object" : "UserSettings",
								"type" : "bool",
								"label" : "mute",
								"inline_label" : true,
								"tooltip" : "This is the mute fx tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_mute_effects_checkbox.mp3",
							},
						}	
					},
					"music_line" : {
						"type" : "HBoxContainer",
						"items" : {
							"music_volume" : {
								"object" : "UserSettings",
								"type" : "int",
								"label" : "music volume",
								"min" : 0,
								"max" : 100,
								"step" : 10,
								"tick_count": 11,
								"ticks_on_borders" : true,
								"tooltip" : "This is the music_volume tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_music_volume_slider.mp3",
								"stretch_ratio" : 5,
							},
							"mute_music" : {
								"object" : "UserSettings",
								"type" : "bool",
								"label" : "mute",
								"inline_label" : true,
								"tooltip" : "This is the mute music tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_mute_music_checkbox.mp3",
							},
						}	
					},
					"voice_over_line" : {
						"type" : "HBoxContainer",
						"items" : {
							"voice_over_volume" : {
								"object" : "UserSettings",
								"type" : "float",
								"label" : "voice over volume",
								"min" : 0,
								"max" : 100,
								"step" : 10,
								"tick_count": 11,
								"ticks_on_borders" : true,
								"tooltip" : "This is the voice_over_volume tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_voice_over_volume_slider.mp3",
								"stretch_ratio" : 5,
							},
							"mute_voice_over" : {
								"object" : "UserSettings",
								"type" : "bool",
								"label" : "mute",
								"inline_label" : true,
								"tooltip" : "This is the mute voice over tooltip",
								"tts_file" : "res://menu_tts_files/loc_en_mute_voice_over_value_checkbox.mp3",
							},
						}	
					},
					"back_operator" : {
						"object" : "UIManager",
						"type" : "operator",
						"label" : "Back",
						"tooltip" : "This is the back operator tooltip",
						"tts_file" : "res://menu_tts_files/loc_en_back.mp3",
					},
			},
		},
		"ui_section_items" : {
			"label" : "UI Sample Items",
			"tts_file" : "res://menu_tts_files/loc_en_ui_sampe_items.mp3",
			"theme" : KENNEY_UI_BLUE,
			"data" : {
				"fx_line" : {
					"type" : "HBoxContainer",
					"items" : {
						"fx_volume" : {
							"object" : "UserSettings",
							"type" : "int",
							"label" : "fx volume",
							"min" : 0,
							"max" : 100,
							"step" : 10,
							"tick_count": 11,
							"ticks_on_borders" : true,
							"tooltip" : "This is the fx_volume tooltip",
							"tts_file" : "res://menu_tts_files/loc_en_effects_volume_slider.mp3",
							"stretch_ratio" : 5,
						},
						"mute_fx" : {
							"object" : "UserSettings",
							"type" : "bool",
							"label" : "mute",
							"inline_label" : true,
							"tooltip" : "This is the mute fx tooltip",
							"tts_file" : "res://menu_tts_files/loc_en_mute_effects_checkbox.mp3",
						},
					}	
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
					"tooltip" : "Operator 2 only available if hover_click is active",
					"tts_file" : "res://menu_tts_files/loc_en_operator_two_button.mp3",
				},
				#########
				"back_operator" : {
					"object" : "UIManager",
					"type" : "operator",
					"label" : "Back",
					"tooltip" : "This is the back operator tooltip",
					"tts_file" : "res://menu_tts_files/loc_en_back.mp3",
				},
			},
		},
	},
	#"main_theme" : KENNEY_UI,
	"basic_tts_files" : {
		"enabled" : "res://menu_tts_files/loc_en_enabled.mp3",
		"disabled" : "res://menu_tts_files/loc_en_disabled.mp3",
		"selected" : "res://menu_tts_files/loc_en_selected.mp3",
	}
}
