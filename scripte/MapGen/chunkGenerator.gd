extends TileMapLayer
class_name chunk_Generator

#vars used for both
var tempdic
var noise_val

#vars for first gen
var startingchunks : int = 3
var chunk_Size : int = 32
var chunk_Cords_X : int
var chunk_Cords_Y : int
var chunk_origin_x
var chunk_origin_y

#vars for continuesly gen
signal extended_ChunkGen_Finished
var offset : int = int(-0.5 * chunk_Size)
var dic_Key : Vector2
var dirtCords : Array[Vector2i] = []
var grassCords : Array[Vector2i] = []
var tmp_Tile_Pos : Vector2i = Vector2i.ZERO
var tmpVectorCords : Vector2
var startingY : int
var startingX : int
var tileXPos : int
var tileYPos : int 

#dictionary template for temporary saving chunks
var tempChunkData : Dictionary = {
	"tilepos": []
}

var grassAtlas : Vector2
var dirtAtlas : Vector2
var sourceId : int

# Called when the node enters the scene tree for the first time.
func _init(grassatlas, dirtatlas, sourceid):
	self.grassAtlas = grassatlas
	self.dirtAtlas = dirtatlas
	self.sourceId = sourceid

func generateChunks(noise,tilemap):
	for chunk_x in range(startingchunks):
		for chunk_y in range(startingchunks):
			tempdic = dupdic()
			chunk_origin_x = (chunk_x - 1.5) * chunk_Size 
			chunk_origin_y = (chunk_y - 1.5) * chunk_Size
			chunk_Cords_X = chunk_x - (startingchunks >> 1)
			chunk_Cords_Y = chunk_y - (startingchunks >> 1)
			#loop to generate chunk tiles
			for x in range(chunk_Size):
				for y in range(chunk_Size):
					tileXPos = chunk_origin_x + x
					tileYPos = chunk_origin_y + y
					noise_val = noise.get_noise_2d(tileXPos, tileYPos)

					if noise_val >= 0.0:
						tilemap.set_cell(Vector2i(tileXPos, tileYPos), sourceId, dirtAtlas)
					else:
						tilemap.set_cell(Vector2i(tileXPos, tileYPos), sourceId, grassAtlas)
					tempdic["tilepos"].append(Vector2(tileXPos,tileYPos))
			
			dic_Key = Vector2(chunk_Cords_X,chunk_Cords_Y)
			chunk_Data.Loaded_Chunks[dic_Key] = tempdic
	#print(arrayOfChunks)
	#print(chunk_Data.Loaded_Chunks)

func extendedChunkGen(toGenChunks, noise,tilemap):
	for chunks in range (toGenChunks.size()):
		tempdic = dupdic()
		dirtCords.clear()
		grassCords.clear()
		tmpVectorCords = toGenChunks[chunks]
		startingX = chunk_Size * int(tmpVectorCords.x)
		startingY = chunk_Size * int(tmpVectorCords.y)
		#loop to generate chunk tiles
		for chunk_X in range(chunk_Size):
			for chunk_Y in range(chunk_Size):
				tileXPos = startingX + chunk_X + offset
				tileYPos = startingY + chunk_Y + offset
				tmp_Tile_Pos = Vector2i(tileXPos,tileYPos)
				noise_val = noise.get_noise_2d(tileXPos, tileYPos)
				
				if noise_val >= 0.0:
					dirtCords.append(tmp_Tile_Pos)
				else:
					grassCords.append(tmp_Tile_Pos)
				tempdic["tilepos"].append(Vector2(tileXPos,tileYPos))
		#batch set tiles
		for pos in dirtCords:
			tilemap.set_cell(pos, sourceId, dirtAtlas)
		for pos in grassCords:
			tilemap.set_cell(pos, sourceId, grassAtlas)
		dic_Key = Vector2(tmpVectorCords.x,tmpVectorCords.y)
		chunk_Data.Loaded_Chunks[dic_Key] = tempdic
	extended_ChunkGen_Finished.emit()

func dupdic() -> Dictionary:
	return {"tilepos": []}.duplicate(true)
#make a rulebook for what tile is for what noise
#consider multithreading
