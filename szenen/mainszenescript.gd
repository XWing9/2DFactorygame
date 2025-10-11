extends Node2D

@export var noise_hieght_Tesxture : NoiseTexture2D

var noise : Noise

var startheight : int = 200
var startwidth : int = 200

func _ready() -> void:
	noise = noise_hieght_Tesxture.noise
	generateWorld()

func generateWorld():
	for x in range(startheight):
		for y in range(startwidth):
			var noise_val = noise.get_noise_2d(x,y)
			print(noise_val)
