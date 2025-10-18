extends State
class_name IdleState

func enter():
	#play idle animation
	pass

func update(_delta):
	pass

func physics_update(_delta):
	pass

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("W") \
	or event.is_action_pressed("S") \
	or event.is_action_pressed("A") \
	or event.is_action_pressed("D"):
		super.switchState(self,"walkstate")
	elif event.is_action_pressed("Q-EnterBuildGUI"):
		#super.switchState(self,"buildstate")
		pass

func exit():
	pass
