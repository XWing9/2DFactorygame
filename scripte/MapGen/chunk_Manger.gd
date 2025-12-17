extends TileMapLayer
class_name chunkManager

@export var noise_height_Texture : NoiseTexture2D
var noise : Noise

var loader : chunk_Loader
var generator : chunk_Generator
var saver : chunk_Saver

@export var player_Radius : int = 2 #range of chunks

var chunk_Entered : bool

@onready var tilemap = $"."
@onready var assets = $"../assets"
@onready var player = $"../player"

var sourceid = 0
var grassAtlas = Vector2(2,1)
var dirtatlas = Vector2(7,1)

func _ready() -> void:
	saver = chunk_Saver.new()
	loader = chunk_Loader.new()
	generator = chunk_Generator.new()
	
	noise = noise_height_Texture.noise
	

func _process(_delta: float) -> void:
	calc_player_Range()
	#print(loader.trackLoadedChunks())
	#checks player pos and radius and depending calls functions

func calc_player_Range():
	#check if new chunks need to be loaded
	#damm accurate calc to find out in with chunk im in
	#keep in mind y is a bit of since the center of the sprite gets taken not the bottom
	var player_Tile_Pos = tilemap.local_to_map(player.global_position)
	chunk_Data.current_Chunk = Vector2i(
		round(float(player_Tile_Pos.x) / chunk_Data.chunk_Size),
		round(float(player_Tile_Pos.y) / chunk_Data.chunk_Size)
	)
	
	print(chunk_Data.current_Chunk,player_Tile_Pos)
	


func load_save_orgeneratechunks(action):
	#checks if it needs to get saved,loaded or newly generated
	if (action == "saving"):
		pass
	elif (action == "loading"):
		print("load chunks")
	elif (action == "generatenew"):
		generator.generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid)
		#saver.saveChunks(arrayOfChunks)
	else:
		print("status is incorrect")
