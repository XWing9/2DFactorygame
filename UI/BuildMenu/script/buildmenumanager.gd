extends MarginContainer

@export var buildMenu: VBoxContainer
@export var smelterButton: Button
@export var minerButton: Button

var ghostSprite: Sprite2D
var overlay: CanvasLayer
var isPlacing := false
var buildingManager : Node

func _ready():
	overlay = CanvasLayer.new()
	overlay.layer = 100
	add_child(overlay)

	ghostSprite = Sprite2D.new()
	ghostSprite.visible = false
	ghostSprite.modulate = Color(1, 1, 1, 0.5)
	overlay.add_child(ghostSprite)

	buildingManager = get_node("/root/Mainszene/Buildings")

	# Connect build buttons
	#switch with real signals
	smelterButton.pressed.connect(func(): on_build_button_pressed(smelterButton))
	minerButton.pressed.connect(func(): on_build_button_pressed(minerButton))

#does the check with button was pressed
func _on_togglemenus_pressed(extra_arg_0: bool, extra_arg_1: bool) -> void:
	if extra_arg_0:
		toggleVisibility(buildMenu)
	elif extra_arg_1:
		print("menu pops up")

#switches the menu to vissible or not visible
func toggleVisibility(object):
	object.visible = !object.visible

func on_build_button_pressed(button: Button):
	var texture = button.icon
	if texture:
		ghostSprite.texture = texture
		ghostSprite.visible = true
		#scales sprite image
		ghostSprite.scale = Vector2(2,2)
		ghostSprite.z_index = 999
		isPlacing = true
		print("Blueprint started with texture size:", texture.get_size())
		#adjust the "smelter" to dynamic thing
		buildingManager.startPlacement("smelter",ghostSprite.texture)
	else:
		print("ERROR: No icon set on", button.name)
