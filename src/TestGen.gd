tool
extends Node

var noise := OpenSimplexNoise.new()

const TERRAIN_HEIGHT := 10

func _ready():
	noise.period = 20

### Layer 0 ###
func _generate0(x: int, y: int) -> int:
	var h := (noise.get_noise_1d(x)+1) * TERRAIN_HEIGHT
	
	var v := 0 if y < h+1 else 1
	if y > h+8: v = 3
	
	return v

### Layer 1 ###
func _generate1(x: int, y: int) -> int:
	var h := (noise.get_noise_1d(x)+1) * TERRAIN_HEIGHT
	
	var v := 0 if y < h else 2
	if y > h+1: v = 1
	if y > h+8: v = 3
	
	if noise.get_noise_2d(x, y) > 0.2: v = 0
	
	return v
