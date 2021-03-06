extends Node2D

var place_block := 10

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
		if place_block > 10:
			place_block = 1
	
	if Input.is_key_pressed(KEY_1):
		place_block = 1
	elif Input.is_key_pressed(KEY_2):
		place_block = 2
	elif Input.is_key_pressed(KEY_3):
		place_block = 3
	elif Input.is_key_pressed(KEY_4):
		place_block = 4
	elif Input.is_key_pressed(KEY_5):
		place_block = 5
	elif Input.is_key_pressed(KEY_6):
		place_block = 6
	elif Input.is_key_pressed(KEY_7):
		place_block = 7
	elif Input.is_key_pressed(KEY_8):
		place_block = 8
	elif Input.is_key_pressed(KEY_9):
		place_block = 9
	elif Input.is_key_pressed(KEY_0):
		place_block = 10
