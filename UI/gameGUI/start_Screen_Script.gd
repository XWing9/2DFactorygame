extends Control
class_name StartGUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_start_game_pressed() -> void:
	scene_Switcher.current_Szene = "GameWorld"
	scene_Switcher.connectSzeneChangeSignal()
	
