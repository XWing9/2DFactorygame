extends Node
class_name chunk_Loader

#for unload_chunks
var startingX : int
var startingY : int
var chunk_Size = 32
var offset : int = int(-0.5 * chunk_Size)
var tmpArray: Array[Vector2i] = []

#for unload_ressources
var toUnloadResources : Array
var toEraseKeys : Array

func load_newChunks():
	#check if chunks exist
	#use signal to say func is finished
	pass

func unload_Chunks(toUnloadChunks,tilemap):
	startingX = 0
	startingY = 0
	tmpArray = []

	for chunk_cords in toUnloadChunks:
		tmpArray.clear()

		startingX = chunk_Size * int(chunk_cords.x)
		startingY = chunk_Size * int(chunk_cords.y)
		# calculate all tile positions for this chunk
		for chunk_X in range(chunk_Size):
			for chunk_Y in range(chunk_Size):
				var tile_pos = Vector2i(
					startingX + chunk_X + offset,
					startingY + chunk_Y + offset
				)
				tmpArray.append(tile_pos)

		# batch erase all tiles for this chunk
		for pos in tmpArray:
			tilemap.erase_cell(pos) 
		chunk_Data.Loaded_Chunks.erase(chunk_cords)

	#call_deferred("emit_Finished_Signal")
	#make loop that checks if chunks need to be saved
	#when yes save when not dont save

func unload_Ressources(toUnloadChunks,assets):
	toUnloadResources = []
	var ressourceData
	for key in chunk_Data.loaded_Assets.keys():
		ressourceData = chunk_Data.loaded_Assets[key]
		
		print(toUnloadChunks)
		print(ressourceData)
		
		if toUnloadChunks.has(ressourceData["chunk"]):
			print("no?")
			toUnloadResources.append(ressourceData["id"])
			toEraseKeys.append(key)
			print(toUnloadResources)
	assets.unloadRessources(toUnloadResources) 
	
	for key in toEraseKeys:
		chunk_Data.loaded_Assets.erase(key)

func check_If_Chunk_is_Saved() -> bool:
	return false

func save_Chunk_To_Disc():
	pass
