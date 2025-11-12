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

func _ready() -> void:
	noise = noise_hieght_Tesxture.noise
	generator = chunk_Generator.new(noise,tilemap,grassAtlas,dirtatlas,sourceid)
	

func _process(_delta: float) -> void:
	try3()
	#checks player pos and radius and depending calls functions

var chunkName : Dictionary = {
		"chunkcords" : null,
		"tilepos" : []
	}

var chunk_size = 32
func loadTilesToDicionary():
	
	var chunks_array : Array = []
	
	for cell in tilemap.get_used_cells():
		var cx = int(floor(cell.x / chunk_size))
		var cy = int(floor(cell.y / chunk_size)) 
		var key = "%d_%d" % [cx, cy]
		if not chunkName.has(key):
			chunkName[key] = {"tilepos": []}
		chunkName[key]["tilepos"].append(cell)
		
	for dict_chunk in chunkName.values():
		chunks_array.append(dict_chunk)
	print(chunks_array)

func trackLoadedTiles():
	#goddot gives tile pos from top to bottom
	var Arrayofchunks : Array
	
	var array_of_loadedTiles = tilemap.get_used_cells()
	var dicDup1 = dupdic()
	var dicDup2 = dupdic()
	var counter = 1
	var i = 0
	while i < array_of_loadedTiles.size():
		dicDup1["tilepos"].append(array_of_loadedTiles[i])
		print(counter)
		print(dicDup1,dicDup2)
		if dicDup1["tilepos"].size() % chunk_size == 0:
			counter += 1
			for a in range(1,chunk_size):
				if i + a >= array_of_loadedTiles.size():
					break 
				dicDup2["tilepos"].append(array_of_loadedTiles[i + a])
			i += chunk_size
		elif counter == chunk_size:
			counter = 0
			Arrayofchunks.append(dicDup1)
			Arrayofchunks.append(dicDup2)
			print(Arrayofchunks)
			dicDup1 = dupdic()
			dicDup2 = dupdic()
		i += 1
	print(array_of_loadedTiles.size())
	

func dupdic() -> Dictionary:
	return {"tilepos": []}.duplicate(true)

#dicDup1["tilepos"].size() % chunk_size == 0

func try3():
	var chunk_size = 32
	var counter = Vector2(0,0)
	var chunkcor = Vector2(0,0)
	var chunks_array : Array = []

	for cell in tilemap.get_used_cells():
		# increment counters
		counter.x += 1
		counter.y += 1

		# move to next chunk horizontally
		if counter.x > chunk_size:
			counter.x = 1
			chunkcor.x += 1

		# move to next chunk vertically
		if counter.y > chunk_size:
			counter.y = 1
			chunkcor.y += 1
			chunkcor.x = 0  # reset X when moving down a row of chunks

		var key = "%d_%d" % [chunkcor.x, chunkcor.y]

		# create dictionary if it doesn't exist
		if not chunkName.has(key):
			chunkName[key] = {
				"chunkcords": chunkcor,
				"tilepos": []
			}

		chunkName[key]["tilepos"].append(cell)

	# convert to array if needed
	for dict_chunk in chunkName.values():
		chunks_array.append(dict_chunk)

	print(chunks_array)


func calc_player_Range():
	#check if new chunks need to be loaded
	pass


#call function per signal
func load_save_orgeneratechunks():
	#checks if it needs to get saved,loaded or newly generated
	if (status == "saving"):
		saver = chunk_Saver.new(player_Pos,player_Radius,chunks_Loaded)
	elif (status == "loading"):
		loader = chunk_Loader.new(player_Pos,player_Radius)
	elif (status == "generatenew"):
		generator = chunk_Generator.new(noise,tilemap,grassAtlas,dirtatlas,sourceid)
	else:
		print("status is incorrect")
