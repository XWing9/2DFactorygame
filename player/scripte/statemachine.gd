extends Node

@export var initial_state : State 
var current_state : State
var states : Dictionary = {}

func _ready():
	var player_node = get_parent() as CharacterBody2D
	var player_sprite = player_node.get_node("AnimatedSprite2D") as AnimatedSprite2D
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = player_node
			child.animated_sprite = player_sprite
			child.Transitioned.connect(on_child_transition)
		
		if initial_state:
			initial_state.enter()
			current_state = initial_state

#takes every key input
func _input(event: InputEvent) -> void:
	# This captures all keyboard/mouse events globally
	if event is InputEventKey and event.pressed:
		current_state.handle_input(event)
		#print("Global key pressed:", event.keycode)

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
	
	print("State: ", current_state.name)
