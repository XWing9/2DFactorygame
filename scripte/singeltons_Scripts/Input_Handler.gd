extends Node

var CurrentInput : String
var active : bool = false

func _unhandled_input(event):
	if active == false:
		return
	
	if event.is_action_pressed("ui_cancel"):
		CurrentInput = "esc"
		print("Keyboard key:", CurrentInput)
