extends CharacterBody2D

# Speed in pixels per second
@export var speed: float = 200.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Input handling
	if Input.is_action_pressed("D"):
		direction.x += 1
	if Input.is_action_pressed("A"):
		direction.x -= 1
	if Input.is_action_pressed("S"):
		direction.y += 1
	if Input.is_action_pressed("W"):
		direction.y -= 1

	# Normalize to avoid faster diagonal movement
	if direction.length() > 0:
		direction = direction.normalized()

	# Move the player
	velocity = direction * speed
	move_and_slide()
