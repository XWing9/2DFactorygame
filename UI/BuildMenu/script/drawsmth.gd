extends Node2D
class_name draw_Grid

var display_Grid : bool = false
var spacing = 16 * 32
var screen_size

func toggle_grid():
	if (display_Grid == false):
		display_Grid = true
		queue_redraw()
	else: 
		display_Grid = false
	print(display_Grid)

func _draw() -> void:
	screen_size = get_viewport_rect().size 
	print(screen_size)
	# when if statement is gone it draws?
	if display_Grid == false:
		return
	print("should draw")
	
	for x in range(0, int(screen_size.x ), spacing):
		draw_line(Vector2(x, 0), Vector2(x, screen_size.y), Color.BLACK, 2)
		
	# draw horizontal lines
	for y in range(0, int(screen_size.y), spacing):
		draw_line(Vector2(0, y), Vector2(screen_size.x, y), Color.BLACK, 2)
