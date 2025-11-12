extends TileMapLayer
class_name chunk_Generator

#take nec info from tile map when called
#generate chunks

#temp let chunk borders get drawn for testing
var startingchunks = 2
var chunk_Size : int = 32
var tempChunkPos : Vector2
var startheight : int = 200
var startwidth : int = 200

var Render_Range : int = 4 #measured in chunks
@export var tiles := {} # Dictionary<Vector2i, Dictionary]
# Called when the node enters the scene tree for the first time.
func _init(noise,tilemap,grassAtlas,dirtatlas,sourceid) -> void:
	generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid)

func generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid):
	var halfchunk = startingchunks / 2
	
	for chunk_x in range(-halfchunk, halfchunk):
		for chunk_y in range(-halfchunk, halfchunk):
			# chunk origin in world coordinates
			var chunk_origin_x = chunk_x * chunk_Size
			var chunk_origin_y = chunk_y * chunk_Size

			for x in range(chunk_Size):
				for y in range(chunk_Size):
					var world_x = chunk_origin_x + x
					var world_y = chunk_origin_y + y

					var noise_val = noise.get_noise_2d(world_x, world_y)

					if noise_val >= 0.0:
						tilemap.set_cell(Vector2(world_x, world_y), sourceid, dirtatlas)
					else:
						tilemap.set_cell(Vector2(world_x, world_y), sourceid, grassAtlas)

func extendedChunkGen():
	pass
