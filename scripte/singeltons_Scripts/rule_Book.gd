extends Node

#generall Rulebook for everything using rules/ruleset
var genRuleBookDic : Dictionary = {
	"GrassLands" : [
		Vector2i(12,15), #Iron
		Vector2i (7,1), #Dirt
		Vector2i(2,1), #Grass
		Vector2i(2,1) #Grass
	], #change rest
	"Forest" : [
		Vector2i(2,3), #ForestGrass
		Vector2i(4,5), #whatever
	]
}

var ressourceRuleBookDic : Dictionary = {
	"GrassLands" : {
		Vector2i(12,15) : "Iron",
		Vector2i (7,1) : "Dirt",
		Vector2i(2,1) : "Grass"
	}, #change rest
	"Forest" : {
		Vector2i(2,3) : "ForestGrass", #ForestGrass
		Vector2i(4,5) : "undefined", #whatever
	}
}
