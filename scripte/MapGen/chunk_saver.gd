extends Node
class_name chunk_Saver

var savingFilePath = "res://GameSaves"
var save_File_Folder_Path : String = "res://GameSaves"

#small chunk dic 
var chunkname : Dictionary = {
	#ev add chunks cords back as key
	"chunk_data" : [
		[
			Vector2.ZERO, 	#tile_cords 
			0,				#type of tile 
			true, 			#is tile free to build on
		]
	]
}
var small_Chunk_Buildings : Dictionary = {
	"buildingcords" : Vector2.ZERO, 
	"items" : ["",""],
	"texture_Path" : "",
	"name" : "" 
}
var cluster_Chunk_Dic : Dictionary = {
	"cluster_cords" : Vector2.ZERO,
	"chunk_Data" : chunkname,
	"building_Data" : small_Chunk_Buildings
}
var region_Chunk_Dic : Dictionary = {
	"region_cords" : Vector2.ZERO,
	"cluster_Data" : cluster_Chunk_Dic
}

func _init() -> void:
	#save chunk data
	pass

func saveChunks(chunksToSave):
	#build stuff to save chunks into dics then into ressource files
	pass
#save chunks into an dictionary and make them into one file
