extends Node
class_name chunk_Loader

func _init() -> void:
	#load chunks when needed
	pass

func load_newChunks():
	#use signal to say func is finished
	pass

func unload_Chunks(toUnloadChunks,tilemap):
	var tmpVectorCords : Vector2i = Vector2i.ZERO
	var startingX
	var startingY
	var chunk_Size = 16
	var tileXPos
	var tileYPos
	var offset : int = int(-0.5 * chunk_Size)
	var tmp_Tile_Pos
	var tmpArray : Array = []
	for chunks in range (toUnloadChunks.size()):
		tmpVectorCords = toUnloadChunks[chunks]
		startingX = chunk_Size * int(tmpVectorCords.x)
		startingY = chunk_Size * int(tmpVectorCords.y)
		#loop to delete chunk tiles from tilemap
		for chunk_X in range(chunk_Size):
			for chunk_Y in range(chunk_Size):
				tileXPos = startingX + chunk_X + offset
				tileYPos = startingY + chunk_Y + offset
				tmp_Tile_Pos = Vector2i(tileXPos,tileYPos)
				tmpArray.append(tmp_Tile_Pos)
		#tmpArray.append(tmp_Tile_Pos)
		print("tmpArray:",tmpArray)
		print("unloadchunksarray:",toUnloadChunks)
		#batch set tiles
		for pos in tmpArray:
			tilemap.erase_cell(pos)
	#call_deferred("emit_Finished_Signal")
	#make loop that checks if chunks need to be saved
	#when yes save when not dont save
	#use goddots erase.cell() function for it

func check_If_Chunk_is_Saved() -> bool:
	return false

func save_Chunk_To_Disc():
	pass
