extends Node

#singelton class to track chunks specific data

var player_pos : Vector2 #redundant since current_chunk is the player pos
var player_Pos_On_tileMap : Vector2
var chunks_loaded : int = 0
var current_Chunk : Vector2i
var chunk_Size : int = 32

var Loaded_Chunks : Dictionary = {
}
