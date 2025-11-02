extends TileMapLayer
class_name chunkGenerator

#take nec info from tile map when called
#generate chunks

#temp let chunk borders get drawn for testing
var startingchunks = 4
var chunk_Size : int = 16

var startheight : int = 200
var startwidth : int = 200

var range : int = 4 #measured in chunks
@export var tiles := {} # Dictionary<Vector2i, Dictionary]
# Called when the node enters the scene tree for the first time.
func _init(noise,tilemap,grassAtlas,dirtatlas,sourceid) -> void:
	generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid)

func generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid):
	for x in range(-startwidth/2, startwidth/2):
		for y in range(-startheight/2, startheight/2):
			var noise_val = noise.get_noise_2d(x,y)
			#if noise is under 0.0 it gets a water tile and vise versa
			if noise_val >= 0.0:
				tilemap.set_cell(Vector2(x,y),sourceid,dirtatlas)
			elif noise_val < 0.0:
				tilemap.set_cell(Vector2(x,y),sourceid,grassAtlas)

func extendedChunkGen():
	pass
