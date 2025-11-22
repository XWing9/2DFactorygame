extends Node
class_name szeneSwitcher

var current_Szene : String
var world
var tile_Map_Ground
var current_Save_Name
var worldAction : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func connectSzeneChangeSignal():
	#signal connected to switchtoworld function when scene is loaded
	get_tree().connect("scene_changed",Callable(self,"switchToWorld"))
	# Switch to the main world scene
	get_tree().change_scene_to_file("res://szenen/Mainszene.tscn")

func switchToWorld():
	
	world = get_tree().current_scene
	
	tile_Map_Ground = world.get_node("Grass")
	
	tile_Map_Ground.load_save_orgeneratechunks(worldAction)
	
	get_tree().disconnect("scene_changed",Callable(self,"switchToWorld"))
