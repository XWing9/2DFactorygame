extends TileMapLayer
class_name chunk_Generator

#take nec info from tile map when called
#generate chunks

#temp let chunk borders get drawn for testing
var startingchunks : int = 2
var chunk_Size : int = 32
var tempChunkPos : Vector2
var startheight : int = 200
var startwidth : int = 200


var Render_Range : int = 4 #measured in chunks

#dictionary template for temporary saving chunks
var tempChunkData : Dictionary = {
	"chunkCords" : Vector2.ZERO,
	"tilePos": []
}


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	pass


func generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid,arrayOfChunks):
	#only thing thats of are the chunk cords, sorting into dic with tile pos works
	var halfchunk = startingchunks / 2
	
	var tempdic
	var chunk_origin_x
	var chunk_origin_y
	var world_x
	var world_y
	var noise_val

	for chunk_x in range(-halfchunk, halfchunk):
		for chunk_y in range(-halfchunk, halfchunk):
			# chunk origin in world coordinates
			tempdic = dupdic()
			tempdic["chunkcords"] = Vector2(chunk_x,chunk_y)
			
			chunk_origin_x = chunk_x * chunk_Size
			chunk_origin_y = chunk_y * chunk_Size
			
			for x in range(chunk_Size):
				for y in range(chunk_Size):
					world_x = chunk_origin_x + x
					world_y = chunk_origin_y + y

					noise_val = noise.get_noise_2d(world_x, world_y)

					if noise_val >= 0.0:
						tilemap.set_cell(Vector2(world_x, world_y), sourceid, dirtatlas)
						
					else:
						tilemap.set_cell(Vector2(world_x, world_y), sourceid, grassAtlas)
					tempdic["tilepos"].append(Vector2(world_x,world_y))
			arrayOfChunks.append(tempdic)
	#print(arrayOfChunks)

#add chunks into dictionary upon generation
func extendedChunkGen():
	pass

func dupdic() -> Dictionary:
	return {"chunkCords" : Vector2.ZERO,"tilepos": []}.duplicate(true)
