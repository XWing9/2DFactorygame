extends TileMapLayer

@export var noise_hieght_Tesxture : NoiseTexture2D

var noise : Noise

var startheight : int = 200
var startwidth : int = 200

#takes tilemap node.
@onready var tilemap = $"."

#id from the tilemap
var sourceid = 0
#where on the tile map the wnated tile is
var bushAtlas = Vector2(5,32)
var stoneAtlas = Vector2(16,32)

func _ready() -> void:
	noise = noise_hieght_Tesxture.noise
	generateWorld()

func generateWorld():
	for x in range(-startwidth/2, startwidth/2):
		for y in range(-startheight/2, startheight/2):
			var noise_val = noise.get_noise_2d(x,y)
			#if noise is under 0.0 it gets a water tile and vise versa
			if noise_val >= 0.5:
				tilemap.set_cell(Vector2(x,y),sourceid,bushAtlas)
			elif noise_val < -0.5:
				tilemap.set_cell(Vector2(x,y),sourceid,stoneAtlas)
