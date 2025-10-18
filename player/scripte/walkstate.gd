extends State

class_name Walkstate

const SPEED := 130.0

func enter():
	pass

func update(_delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("D"):
		dir.x += 1
	if Input.is_action_pressed("A"):
		dir.x -= 1
	if Input.is_action_pressed("S"):
		dir.y += 1
	if Input.is_action_pressed("W"):
		dir.y -= 1

	if dir != Vector2.ZERO:
		dir = dir.normalized()
		player.velocity = dir * currentPlayerSpeed
	else:
		# No input → go idle
		switchState(self,"idlestate")

func physics_update(delta: float) -> void:
	player.move_and_slide()

func handle_input(event: InputEvent) -> void:
	pass

func exit():
	pass
