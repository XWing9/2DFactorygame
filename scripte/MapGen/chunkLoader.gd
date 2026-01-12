extends Node
class_name chunk_Loader

func _init() -> void:
	#load chunks when needed
	pass

func load_newChunks():
	#use signal to say func is finished
	pass

func unload_Chunks(toUnloadChunks,tilemap):
	var startingX
	var startingY
	var chunk_Size = 16
	var offset : int = int(-0.5 * chunk_Size)
	var tmpArray: Array[Vector2i] = []

	for chunk_coords in toUnloadChunks:
		tmpArray.clear()
		
		startingX = chunk_Size * int(chunk_coords.x)
		startingY = chunk_Size * int(chunk_coords.y)

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
	#call_deferred("emit_Finished_Signal")
	#make loop that checks if chunks need to be saved
	#when yes save when not dont save
	#use goddots erase.cell() function for it

func check_If_Chunk_is_Saved() -> bool:
	return false

func save_Chunk_To_Disc():
	pass
