extends Node
class_name chunk_Loader

func _init() -> void:
	#load chunks when needed
	pass

func load_newChunks():
	pass

func unload_Chunks():
	pass

func trackLoadedChunks():
	chunk_Data.chunks_loaded = chunk_Data.Loaded_Chunks.size()
	#depending on performance yeet return out
	return chunk_Data.chunks_loaded

func unloadChunks():
	pass
