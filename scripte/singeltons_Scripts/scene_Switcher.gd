extends Node

var current_Szene : String
var world
var tile_Map_Ground
var current_Save_Name
var worldAction : String


func connectSzeneChangeSignal():
	#signal connected to switchtoworld function when scene is loaded
	get_tree().connect("scene_changed",Callable(self,"switchToWorld"))
	# Switch to the main world scene
	get_tree().change_scene_to_file("res://szenen/Mainszene.tscn")

func switchToWorld():
	Input_Handler.active = false
	
	world = get_tree().current_scene
	
	tile_Map_Ground = world.get_node("Grass")
	
	tile_Map_Ground.load_save_orgeneratechunks(worldAction)
	
	get_tree().disconnect("scene_changed",Callable(self,"switchToWorld"))

func switchToMainScreen():
	get_tree().connect("scene_changed",Callable(self,"switch"))
	
	get_tree().change_scene_to_file("res://UI/gameGUI/StartScreen.tscn")
	
func switch():
	Input_Handler.active = false
	
	get_tree().disconnect("scene_changed",Callable(self,"switch"))
