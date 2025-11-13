extends TileMapLayer
class_name chunkManager

@export var noise_hieght_Tesxture : NoiseTexture2D
var noise : Noise

var loader : chunk_Loader
var generator : chunk_Generator
var saver : chunk_Saver

var player_Pos : Vector2
var player_Radius : int #range of chunks
var chunks_Loaded : int
var chunk_Entered : bool

var status : String 

@onready var tilemap = $"."
@onready var assets = $"../assets"
var sourceid = 0
var grassAtlas = Vector2(2,1)
var dirtatlas = Vector2(7,1)

var arrayOfChunks : Array 

func _ready() -> void:
	saver = chunk_Saver.new()
	loader = chunk_Loader.new()
	generator = chunk_Generator.new()
	
	noise = noise_hieght_Tesxture.noise
	

func _process(_delta: float) -> void:
	pass
	#checks player pos and radius and depending calls functions

func calc_player_Range():
	#check if new chunks need to be loaded
	pass


#call function per signal
func load_save_orgeneratechunks():
	#checks if it needs to get saved,loaded or newly generated
	if (status == "saving"):
		pass
	elif (status == "loading"):
		pass
	elif (status == "generatenew"):
		generator.generateChunks(noise,tilemap,grassAtlas,dirtatlas,sourceid,arrayOfChunks)
		saver.saveChunks(arrayOfChunks)
	else:
		print("status is incorrect")
