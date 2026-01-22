extends Node2D
class_name RessourceParent

@export var toTakeHits : int
@export var hitCount : int = 0
@export var timerLength : float = 1.5
@export var objectName : String

signal destroyed
signal hit_Taken

@onready var hit_Timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func onHit():
	#when hit start _process
	hitCount += 1
	hit_Timer.start(timerLength)
	
	hit_Taken.emit()
	#tmp change to paint sprite red
	sprite.play("hit")
	
	if hitCount >= toTakeHits:
		destroy()

func onTimerTimeout():
	hitCount = 0
	
func destroy():
	sprite.play("break")
	await  sprite.animation_finished
	destroyed.emit()
	queue_free()
