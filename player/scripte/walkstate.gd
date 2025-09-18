extends State

class_name Walkstate

const SPEED := 130.0

func enter():
	pass

func physics_update(delta: float) -> void:
	super.physics_update(delta)

	var move_dir := Vector2.ZERO

	# Handle input for 4 directions
	if Input.is_action_pressed("D"):
		move_dir.x += 1
	if Input.is_action_pressed("A"):
		move_dir.x -= 1
	if Input.is_action_pressed("S"):
		move_dir.y += 1
	if Input.is_action_pressed("W"):
		move_dir.y -= 1

	if move_dir != Vector2.ZERO:
		move_dir = move_dir.normalized()
	
	player.velocity = move_dir * SPEED
	player.move_and_slide()
