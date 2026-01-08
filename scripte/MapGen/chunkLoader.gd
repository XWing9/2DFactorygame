extends Node
class_name chunk_Loader

func _init() -> void:
	#load chunks when needed
	pass

func load_newChunks():
	#use signal to say func is finished
	pass

func unload_Chunks(toUnloadChunks):
	#make loop that checks if chunks need to be saved
	#when yes save when not dont save
	#use goddots erase.cell() function for it
	pass

func check_If_Chunk_is_Saved() -> bool:
	return false

func save_Chunk_To_Disc():
	pass
