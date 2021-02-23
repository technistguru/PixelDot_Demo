extends Node2D

var place_block := 1

onready var preview_tilemap := $TileMap

func _process(_delta):
	var mousePos := get_global_mouse_position()
	mousePos /= 32
	var x := floor(mousePos.x)
	var y := floor(mousePos.y)
	
	if Input.is_action_pressed("place"):
		$BlockMap.set_block(x, y, 1, place_block)
	
	elif Input.is_action_pressed("remove"):
		$BlockMap.set_block(x, y, 1, 0)
	
	preview_tilemap.clear()
	preview_tilemap.set_cell(x, y, place_block-1)

func _input(event):
	if event.is_action_pressed("change_block"):
		place_block += 1
		if place_block > 9:
			place_block = 1
