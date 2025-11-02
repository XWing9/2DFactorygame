extends TileMapLayer

#change to extern file chunk generation
@export var noise_hieght_Tesxture : NoiseTexture2D

var noise : Noise

#take chunkgen class
@export var chunkGenRef : Script
var chunk_Generator

var startheight : int = 200
var startwidth : int = 200

#takes tilemap node.
@onready var tilemap = $"."

#id from the tilemap
var sourceid = 0
#where on the tile map the wnated tile is
var grassAtlas = Vector2(2,1)
var dirtatlas = Vector2(7,1)

func _ready() -> void:
	noise = noise_hieght_Tesxture.noise
	chunk_Generator = chunkGenRef.new(noise,tilemap,grassAtlas,dirtatlas,sourceid)

func generateWorld():
	for x in range(-startwidth/2, startwidth/2):
		for y in range(-startheight/2, startheight/2):
			var noise_val = noise.get_noise_2d(x,y)
			#if noise is under 0.0 it gets a water tile and vise versa
			if noise_val >= 0.0:
				tilemap.set_cell(Vector2(x,y),sourceid,dirtatlas)
			elif noise_val < 0.0:
				tilemap.set_cell(Vector2(x,y),sourceid,grassAtlas)
