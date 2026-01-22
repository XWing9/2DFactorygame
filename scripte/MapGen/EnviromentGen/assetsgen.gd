extends Node

@export var loadedAssets : Array = []
@export var noiseMap : NoiseTexture2D

@onready var szene := $"."
var noiseVal
#tmp var with szenes, change to list or so
@onready var stone = "res://szenen/ressourceTypeSzene/GrassLands/Stone.tscn"
var busch : Node2D

signal finishedNoise

var noiseValArray : Array = []

func spawnAssets():
	print("assets entered")
	for x in range(200):
		noiseVal = noiseMap.get_noise_2d(x,x)
		shouldAssetSpawn()
		await finishedNoise
		for i in range(noiseValArray.size()):
			szene.add_child(stone)

func shouldAssetSpawn():
	if noiseVal > 0.6:
		noiseValArray.append(noiseVal)
		finishedNoise.emit()
