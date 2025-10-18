extends Node

class_name State 
signal Transitioned(currentstate, newState)

@export var player: CharacterBody2D
var animated_sprite: AnimatedSprite2D
var direction: int = 0
@export var currentPlayerSpeed = 100

func enter():
	pass
	
func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func switchState(currentstate,newState):
	Transitioned.emit(currentstate,newState)
