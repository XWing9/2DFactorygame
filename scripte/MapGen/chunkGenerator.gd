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
var dic_Key : Vector2i
var tmp_Tile_Pos_Array : Array
var tmp_Tile_Pos : Vector2i = Vector2i.ZERO
var tmpVectorCords : Vector2i
var tmpVectorCordsArray : Array
var startingY : int
var startingX : int
var tileXPos : int
var tileYPos : int 


var ironOretest : Vector2i = Vector2i(12,15)
#dictionary template for temporary saving chunks
var tempChunkData : Dictionary = {
	"tilepos": []
}

var genRuleBookDic : Dictionary = {
	"GrassLands" : [
		Vector2i(12,15), #Iron
		Vector2i (7,1), #Dirt
		Vector2i(2,1), #Grass
		Vector2i(2,1) #Grass
	], #change rest
	"Forest" : [
		Vector2i(2,3), #ForestGrass
		Vector2i(4,5), #whatever
	]
}

var biome : String
var biome_tiles : Array
var tmpAtlasCords : Vector2i

var grassAtlas : Vector2i
var dirtAtlas : Vector2i
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
			
			biome = determineBiome(chunk_Cords_X,chunk_Cords_Y)
			biome_tiles = genRuleBookDic[biome]
			
			#loop to generate chunk tiles
			for x in range(chunk_Size):
				for y in range(chunk_Size):
					tileXPos = chunk_origin_x + x
					tileYPos = chunk_origin_y + y
					noise_val = noise.get_noise_2d(tileXPos, tileYPos)

					tmpAtlasCords = determineTile(noise_val,biome_tiles)
					
					tilemap.set_cell(Vector2i(tileXPos, tileYPos), sourceId, tmpAtlasCords)
					tempdic["tilepos"].append(Vector2i(tileXPos,tileYPos))
			
			dic_Key = Vector2i(chunk_Cords_X,chunk_Cords_Y)
			chunk_Data.Loaded_Chunks[dic_Key] = tempdic
	#print(arrayOfChunks)
	#print(chunk_Data.Loaded_Chunks)

func extendedChunkGen(toGenChunks, noise,tilemap):
	for chunks in range (toGenChunks.size()):
		tempdic = dupdic()
		tmpVectorCordsArray.clear()
		tmp_Tile_Pos_Array.clear()
		tmpVectorCords = toGenChunks[chunks]
		startingX = chunk_Size * int(tmpVectorCords.x)
		startingY = chunk_Size * int(tmpVectorCords.y)
		
		#determine biome
		biome = determineBiome(startingX,startingY)
		biome_tiles = genRuleBookDic[biome]
		
		#loop to generate chunk tiles
		for chunk_X in range(chunk_Size):
			for chunk_Y in range(chunk_Size):
				tileXPos = startingX + chunk_X + offset
				tileYPos = startingY + chunk_Y + offset
				tmp_Tile_Pos = Vector2i(tileXPos,tileYPos)
				noise_val = noise.get_noise_2d(tileXPos, tileYPos)

				tmpAtlasCords = determineTile(noise_val,biome_tiles)
				tmpVectorCordsArray.append(tmpAtlasCords)
				tmp_Tile_Pos_Array.append(tmp_Tile_Pos)
				
				tempdic["tilepos"].append(Vector2i(tileXPos,tileYPos))
		#batch set tiles
		for i in range(tmp_Tile_Pos_Array.size()):
			tilemap.set_cell(tmp_Tile_Pos_Array[i], sourceId, tmpVectorCordsArray[i])
		
		dic_Key = Vector2i(tmpVectorCords.x,tmpVectorCords.y)
		chunk_Data.Loaded_Chunks[dic_Key] = tempdic
	call_deferred("emit_Finished_Signal")

func emit_Finished_Signal():
	extended_ChunkGen_Finished.emit()

func dupdic() -> Dictionary:
	return {"tilepos": []}.duplicate(true)

func determineTile(noise, listOfTiles):
	print(noise)
	#i have no ide what im doing here?
	
	var t = clamp((noise + 1.0) * 0.5, 0.0, 0.999)
	var index := int(t * listOfTiles.size())
	
	return listOfTiles[index]


func determineBiome(x: int, y: int):
	return "GrassLands"
#consider multithreading

#next gen steps:
#Separate biome noise from terrain noise
#Ore clusters using a second noise
#Biome blending at chunk borders
#Weighted ores per biome
