extends Node

@export var building_manager: Node
var buildingName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#put building loading inside
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func placeBuilding(type,buildingImage):
	
	print("Placed building",type)
	
	var sprite = Sprite2D.new()
	sprite.texture = buildingImage
	
	var tilemap = get_parent().get_node("Grass") # <-- adjust path if needed
	var cell_pos = tilemap.local_to_map(get_viewport().get_camera_2d().get_global_mouse_position())
	var world_pos = tilemap.map_to_local(cell_pos)
	
	sprite.position = world_pos
	sprite.z_index = 1
	
	add_child(sprite)

func safeBuilding():
	pass
