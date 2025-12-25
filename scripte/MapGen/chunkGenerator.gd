extends TileMapLayer
class_name chunk_Generator

var startingchunks : int = 3
var chunk_Size : int = 32

var tempdic
var noise_val
var offset : int = int(-0.5 * chunk_Size)

#dictionary template for temporary saving chunks
var tempChunkData : Dictionary = {
	"tilepos": []
}

# Called when the node enters the scene tree for the first time.
func _init(noise, tilemap, grassAtlas, dirtAtlas, sourceid):
	noise = noise
	tilemap = tilemap
	grassAtlas = grassAtlas
	dirtAtlas = dirtAtlas
	sourceid = sourceid

func generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid):
	#only thing thats of are the chunk cords, sorting into dic with tile pos works
	
	var dic_Key
	var chunk_origin_x
	var chunk_origin_y
	var world_x
	var world_y
	var chunk_Cords_X
	var chunk_Cords_Y

	for chunk_x in range(startingchunks):
		for chunk_y in range(startingchunks):
			# chunk origin in world coordinates
			tempdic = dupdic()
			
			chunk_origin_x = (chunk_x - 1.5) * chunk_Size 
			chunk_origin_y = (chunk_y - 1.5) * chunk_Size
			chunk_Cords_X = chunk_x - (startingchunks >> 1)
			chunk_Cords_Y = chunk_y - (startingchunks >> 1)
			print(chunk_origin_x,chunk_origin_y)
			for x in range(chunk_Size):
				for y in range(chunk_Size):
					world_x = chunk_origin_x + x
					world_y = chunk_origin_y + y

					noise_val = noise.get_noise_2d(world_x, world_y)

					if noise_val >= 0.0:
						tilemap.set_cell(Vector2i(world_x, world_y), sourceid, dirtatlas)
						
					else:
						tilemap.set_cell(Vector2i(world_x, world_y), sourceid, grassAtlas)
					tempdic["tilepos"].append(Vector2(world_x,world_y))
			
			dic_Key = Vector2(chunk_Cords_X,chunk_Cords_Y)
			chunk_Data.Loaded_Chunks[dic_Key] = tempdic
	#print(arrayOfChunks)
	#print(chunk_Data.Loaded_Chunks)

#add chunks into dictionary upon generation
func extendedChunkGen(toGenChunks, noise,tilemap,grassAtlas,dirtatlas,sourceid):
	#make more clean and efizient
	var tmpVector : Vector2
	var startingY : int
	var startingX : int
	var chunkX : int
	var chunkY : int
	
	for chunks in range (toGenChunks.size()):
		tempdic = dupdic()
		tmpVector = toGenChunks[chunks]
		startingX = chunk_Size * int(tmpVector.x)
		startingY = chunk_Size * int(tmpVector.y)
		for chunk_X in range(chunk_Size):
			for chunk_Y in range(chunk_Size):
				chunkX = startingX + chunk_X + offset
				chunkY = startingY + chunk_Y + offset
				noise_val = noise.get_noise_2d(chunkX, chunkY)
				
				if noise_val >= 0.0:
					tilemap.set_cell(Vector2i(chunkX, chunkY), sourceid, dirtatlas)
						
				else:
					tilemap.set_cell(Vector2i(chunkX, chunkY), sourceid, grassAtlas)

func dupdic() -> Dictionary:
	return {"tilepos": []}.duplicate(true)

#make a rulebook for what tile is for what noise
#make a constructor to have a generic thing for noise etc
