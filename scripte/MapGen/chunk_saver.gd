extends Node
class_name chunk_Saver

var filePath
var save_File_Folder_Path : String = "res://GameSaves"

#small chunk dic 
var chunkname : Dictionary = {
	"chunk_data" : [
		Vector2.ZERO, 	#tile_cords 
		0,				#type of tile 
		true, 			#is tile free to build on
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

func _init(player_Pos,player_Range,loaded_Chunks) -> void:
	#save chunk data
	pass

func saveChunks():
	pass
#save chunks into an dictionary and make them into one file
