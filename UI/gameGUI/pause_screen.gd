extends CanvasLayer

@onready var pause_screen : CanvasLayer = $"."
# Called when the node enters the scene tree for the first time.



func _on_back_pressed() -> void:
	pause_screen.hide()


func _on_mainscreen_pressed() -> void:
	scene_Switcher.switchToMainScreen()

func _unhandled_input(event):
	
	if event.is_action_pressed("ui_cancel"):
		pause_screen.show()
