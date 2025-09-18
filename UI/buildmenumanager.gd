extends MarginContainer

@export var buildMenu: VBoxContainer
@export var smelterButton: Button
@export var minerButton: Button

var ghostSprite: Sprite2D
var overlay: CanvasLayer
var isPlacing := false
var buildingManager : Node
var tileMapLayer : TileMapLayer

func _ready():
	overlay = CanvasLayer.new()
	overlay.layer = 100
	add_child(overlay)

	ghostSprite = Sprite2D.new()
	ghostSprite.visible = false
	ghostSprite.modulate = Color(1, 1, 1, 0.5)
	overlay.add_child(ghostSprite)

	buildingManager = get_node("/root/Mainszene/Buildings")
	add_child(buildingManager)
	
	tileMapLayer = get_node("/root/Mainszene/Grass")
	add_child(tileMapLayer)
	# Connect build buttons
	#switch with real signals
	smelterButton.pressed.connect(func(): on_build_button_pressed(smelterButton))
	minerButton.pressed.connect(func(): on_build_button_pressed(minerButton))

func on_build_button_pressed(button: Button):
	var tex = button.icon
	if tex:
		ghostSprite.texture = tex
		ghostSprite.visible = true
		#scales sprite image
		ghostSprite.scale = Vector2(3,3)
		ghostSprite.z_index = 999
		isPlacing = true
		print("Blueprint started with texture size:", tex.get_size())
	else:
		print("ERROR: No icon set on", button.name)

func _process(_delta):
	if isPlacing:
		var mouse_world = get_viewport().get_camera_2d().get_global_mouse_position()
		var cell_pos = tileMapLayer.local_to_map(tileMapLayer.to_local(mouse_world))
		var world_pos = tileMapLayer.map_to_local(cell_pos)
		ghostSprite.global_position = tileMapLayer.to_global(world_pos)

func _unhandled_input(event):
	if isPlacing and event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			ghostSprite.visible = false
			isPlacing = false
			buildingManager.placeBuilding("smelter",ghostSprite.texture)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("Cancelled")
			ghostSprite.visible = false
			isPlacing = false

func toggleVisibility(object):
	object.visible = !object.visible

func _on_togglemenus_pressed(extra_arg_0: bool, extra_arg_1: bool) -> void:
	if extra_arg_0:
		toggleVisibility(buildMenu)
	elif extra_arg_1:
		print("menu pops up")
