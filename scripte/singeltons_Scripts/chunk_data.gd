extends Node

#singelton class to track chunks specific data

var player_pos : Vector2 #redundant since current_chunk is the player pos
var player_Pos_On_tileMap : Vector2
var chunks_loaded : int = 0
var current_Chunk : Vector2i
var chunk_Size : int = 32

var currentBiome : String = "GrassLands" #let it change dynamiclly in future

var Loaded_Chunks : Dictionary = {
}

#asset gen stuff
var toSpawnAssets : Dictionary = {
}

var loaded_Assets : Dictionary = {
	#Vector2i(0,0) : { #postion of ressource
		#"biome" : "GrassLands",
		#"type" : "stone",
		#"chunk" : Vector2i(0,0),
	#}
}
