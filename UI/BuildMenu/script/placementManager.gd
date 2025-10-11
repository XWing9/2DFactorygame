extends Node

@export var building_manager: Node
@export var tileMapLayer: TileMapLayer
var buildingGUIManager

var currentBuildingType := ""
var currentBuildingImage : Texture2D

var mousePos
var cellPos
var worldPos
var tileSize
var worldPosLocal

func _ready() -> void:
	buildingGUIManager = get_node("/root/Mainszene/GameUI/MarginContainer")
	tileMapLayer = get_node("/root/Mainszene/Grass")

func startPlacement(type: String, texture: Texture2D):
	currentBuildingType = type
	currentBuildingImage = texture
	buildingGUIManager.isPlacing = true

func _process(_delta):
	if not buildingGUIManager.isPlacing:
		return
		
	calcPos()
	var cam := get_viewport().get_camera_2d()
	var screen_pos = cam.get_screen_transform() * worldPos
	buildingGUIManager.ghostSprite.position = screen_pos


func _unhandled_input(event):
	if not buildingGUIManager.isPlacing:
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Finalize placement
			placeBuilding(currentBuildingType, currentBuildingImage)
			buildingGUIManager.isPlacing = false
			buildingGUIManager.ghostSprite.visible = false

		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("Cancelled placement")
			buildingGUIManager.isPlacing = false
			buildingGUIManager.ghostSprite.visible = false

func placeBuilding(type: String, buildingImage: Texture2D):
	print("Placed building:", type)

	var sprite = Sprite2D.new()
	sprite.texture = buildingImage

	calcPos()
	
	sprite.position = worldPos
	sprite.z_index = 1

	add_child(sprite)

func calcPos():
	# 1. Get global mouse position
	mousePos = get_viewport().get_camera_2d().get_global_mouse_position()
	
	# 2. Convert mouse to local TileMap coordinates and snap to tile
	cellPos = tileMapLayer.local_to_map(tileMapLayer.to_local(mousePos))
	worldPosLocal = tileMapLayer.map_to_local(Vector2(cellPos))

	# 3. Offset to center the sprite on the tile
	tileSize = Vector2(tileMapLayer.tile_set.tile_size)
	worldPosLocal += tileSize / 2

	# 4. Convert to global for CanvasLayer
	worldPos = tileMapLayer.to_global(worldPosLocal)
