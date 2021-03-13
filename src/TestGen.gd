tool
extends Node

const TERRAIN_HEIGHT := 10
const TREE_THRESHOLD := 0.55
const TREE_HEIGHT_MIN := 2
const TREE_HEIGHT_MAX := 5
const TREE_LEAVES_MIN := 3
const TREE_LEAVES_MAX := 5

onready var block_map := get_parent()

var ground_noise := OpenSimplexNoise.new()
var cave_noise := OpenSimplexNoise.new()
var tree_noise := OpenSimplexNoise.new()

func _ready():
	ground_noise.period = 20
	cave_noise.period = 20
	
	tree_noise.octaves = 1
	tree_noise.period = 1

func get_height(x: int) -> int:
	return int((ground_noise.get_noise_1d(x)+1) * TERRAIN_HEIGHT)

func get_cave(x: int, y: int) -> bool:
	return cave_noise.get_noise_2d(x, y) > 0.2


### Layer 0 ###
func _generate0(x: int, y: int) -> int:
	var h := get_height(x)
	
	var v := 0 if y < h+1 else 1
	if y > h+8: v = 3
	
	return v

### Layer 1 ###
func _generate1(x: int, y: int) -> int:
	var h := get_height(x)
	
	var v := 0 if y < h else 2
	if y > h: v = 1
	if y > h+8: v = 3
	
	if get_cave(x, y): v = 0
	
	return v

func _finish_chunk(chunk_rect: Rect2) -> void:
	for x in range(chunk_rect.position.x, chunk_rect.end.x):
		var height := get_height(x)
		if height < chunk_rect.position.y or height > chunk_rect.end.y:
			continue
		
		var tree := tree_noise.get_noise_1d(x)
		var left_tree := tree_noise.get_noise_1d(x-1)
		if tree < TREE_THRESHOLD or left_tree >= TREE_THRESHOLD or get_cave(x, height):
			continue
		
		
		## Generate Tree
		
		# Trunk
		var tree_start := height
		var tree_end := tree_start - int(randf()*(TREE_HEIGHT_MAX-TREE_HEIGHT_MIN) + TREE_HEIGHT_MIN)
		
		for y in range(tree_end, tree_start):
			block_map.set_block(x, y, 0, 11)
		
		# Leaves
		var leaves_start := tree_end
		var leaves_end := leaves_start - int(randf()*(TREE_LEAVES_MAX-TREE_LEAVES_MIN) + TREE_LEAVES_MIN)
		
		for y in range(leaves_end, leaves_start):
			block_map.set_block(x-1, y, 0, 12)
			block_map.set_block(x, y, 0, 12)
			block_map.set_block(x+1, y, 0, 12)
		block_map.set_block(x, leaves_end-1, 0, 12)
