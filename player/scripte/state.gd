extends Node

class_name State 
signal Transitioned

var player: CharacterBody2D
var animated_sprite: AnimatedSprite2D
var direction: int = 0

func enter():
	pass
	
func exit():
	pass

func update(_delta: float):
	direction = Input.get_axis("move_left", "move_right")

func physics_update(_delta: float):
	direction = Input.get_axis("move_left", "move_right")
	checkcollision()

func checkcollision():
	for i in player.get_slide_collision_count():
		var collision = player.get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("Enemys"):
			emit_signal("Transitioned",self,"playerDamage")
