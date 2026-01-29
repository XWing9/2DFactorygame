extends Node

@onready var szene := $"."

#tmp var with szenes, change to list or so
@export var stone_Szene: PackedScene
var stone
@export var bush_Szene : PackedScene
var bush

var dictionaryKeys : Array
var avaibleRessourceListe : Dictionary
var ressourcePos : Vector2i
var ressourceVector
var toAddSzene : Node2D
var dicKey
var dicKeyEntry
var rulebookRessource
var currentType : String

func spawnAssets():
	#change this bunch of code to smth good
	dictionaryKeys = chunk_Data.toSpawnAssets.keys()
	avaibleRessourceListe = ruleBook.ressourceRuleBookDic[chunk_Data.currentBiome]
	#print(avaibleRessourceListe)
	
	for i in range(dictionaryKeys.size()):
		
		dicKey = dictionaryKeys[i]
		dicKeyEntry = chunk_Data.toSpawnAssets[dicKey]
		ressourceVector = dicKeyEntry["ground"]
		#print(ressourceVector)
		rulebookRessource = avaibleRessourceListe[ressourceVector]
		
		if avaibleRessourceListe.has(ressourceVector):
			if rulebookRessource == "Dirt":
				toAddSzene = stone_Szene.instantiate()
				currentType = "stone"
			elif rulebookRessource == "Grass":
				toAddSzene = bush_Szene.instantiate()
				currentType = "bush"
		
		ressourcePos = dictionaryKeys[i]
		ressourcePos = Vector2i(
			ressourcePos.x * 16,
			ressourcePos.y * 16
		)
		toAddSzene.position = ressourcePos
		szene.add_child(toAddSzene)
		#find way to get real chunk data in here
		chunk_Data.loaded_Assets[ressourcePos] = {
			"type" : currentType,
			"chunk" : chunk_Data.current_Chunk,
			"biome" : chunk_Data.currentBiome,
			"id" : toAddSzene
		}
	chunk_Data.toSpawnAssets.clear()

func shouldAssetSpawn():
	pass

func unloadRessources(toUnloadResources):
	print("entered")
	for ressource in toUnloadResources:
		print("loop entered")
		if is_instance_valid(ressource):
			ressource.queue_free()
