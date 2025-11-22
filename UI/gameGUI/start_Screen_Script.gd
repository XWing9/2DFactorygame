extends Control
class_name StartGUI

@onready var StartingGuiBox = $HBoxContainer/StartingGUI
@onready var SaveOptions = $HBoxContainer/SaveOptions

@onready var Settings_Grid_GUI = $Settings_GUI
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_start_game_pressed() -> void:
	StartingGuiBox.hide()
	SaveOptions.show()

func _on_back_to_start_gui_pressed() -> void:
	StartingGuiBox.show()
	SaveOptions.hide()


func _on_new_game_pressed() -> void:
	scene_Switcher.current_Szene = "Mainszene"
	scene_Switcher.worldAction = "generatenew"
	scene_Switcher.connectSzeneChangeSignal()

func _on_load_game_pressed() -> void:
	scene_Switcher.current_Szene = "Mainszene"
	scene_Switcher.worldAction = "loading"
	scene_Switcher.connectSzeneChangeSignal()


func _on_settings_pressed() -> void:
	Settings_Grid_GUI.show()
	StartingGuiBox.hide()


func _on_quit_pressed() -> void:
	get_tree().quit()
