extends TileMapLayer
class_name chunkManager

@export var noise_height_Texture : NoiseTexture2D
var noise : Noise

var loader : chunk_Loader
var generator : chunk_Generator
var saver : chunk_Saver

@export var player_Radius : int = 1 #range of chunks

var chunk_Entered : bool

@onready var tilemap = $"."
@onready var assets = $"../assets"
@onready var player = $"../player"

var sourceid = 0
var grassAtlas = Vector2i(2,1)
var dirtatlas = Vector2i(7,1)

#calc_Player_Pos
var player_Tile_Pos : Vector2
var last_Player_Pos : Vector2i = Vector2i(0,0)

#calc_Player_Range
var toLoadChunks : Array = []
var toUnloadChunks : Array = []
var tmpPlayerPos : Vector2i

func _ready() -> void:
	saver = chunk_Saver.new()
	loader = chunk_Loader.new()
	generator = chunk_Generator.new(grassAtlas,dirtatlas,sourceid)
	
	noise = noise_height_Texture.noise

func _process(_delta: float) -> void:
	calc_Player_Pos()
	#print(chunk_Data.Loaded_Chunks.keys())

func calc_Player_Pos():
	#damm accurate calc to find out in with chunk im in
	#keep in mind y is a bit of since the center of the sprite gets taken not the bottom
	player_Tile_Pos = tilemap.local_to_map(player.global_position)
	chunk_Data.current_Chunk = Vector2i(
		round(float(player_Tile_Pos.x) / chunk_Data.chunk_Size),
		round(float(player_Tile_Pos.y) / chunk_Data.chunk_Size)
	)
	
	#checks if new chunks need to be loaded
	if last_Player_Pos != chunk_Data.current_Chunk:
		calc_Player_Range()
		last_Player_Pos = chunk_Data.current_Chunk
	#print(chunk_Data.current_Chunk,player_Tile_Pos)

func calc_Player_Range():
	toUnloadChunks = []
	toLoadChunks = []
	tmpPlayerPos = Vector2i(chunk_Data.current_Chunk)
	for x in range(-1,2):
		for y in range(-1,2):
			toLoadChunks.append(tmpPlayerPos + Vector2i(x, y))
	
	toUnloadChunks = toLoadChunks.duplicate()
	
	#removes any chunks that are alreay loaded
	for chunk in chunk_Data.Loaded_Chunks.keys():
		if toLoadChunks.has(chunk):
			toLoadChunks.erase(chunk)
	
	#checks if chunks need to be loaded or gnerated
	if loader.check_If_Chunk_is_Saved():
		loader.load_newChunks()
		#also use await maybe
	else:
		generator.extendedChunkGen(toLoadChunks,noise,tilemap)
		await generator.extended_ChunkGen_Finished
	
	#filters all keys that are in the dictionary but not in the array and replacem them with it
	toUnloadChunks = chunk_Data.Loaded_Chunks.keys().filter(
		func(key):
			return not toUnloadChunks.has(key)
	)
	
	if toUnloadChunks.size() != 0:
		loader.unload_Chunks(toUnloadChunks,tilemap)
	#print("to unload chunks:",toUnloadChunks)
	#print("loaded chunks:",chunk_Data.Loaded_Chunks.keys())

func load_save_orgeneratechunks(action):
	#checks if it needs to get saved,loaded or newly generated
	if (action == "saving"):
		pass
	elif (action == "loading"):
		print("load chunks")
	elif (action == "generatenew"):
		generator.generateChunks(noise,tilemap)
		#saver.saveChunks(arrayOfChunks)
	else:
		print("status is incorrect")
