extends Node


const LEVEL_DATA_PATH: String = "res://data/level_data.json"


var _level_data: Dictionary = {}


func _enter_tree() -> void:
	load_level_data()


func add_tiles_for_layer(layout: LevelLayout, layer_type: TileLayers.LayerType, tile_coords: Array) -> void:
	for tc in tile_coords:
		layout.add_tile_to_layer(tc.x, tc.y, layer_type)


func setup_level(_level_number: String, raw_level_data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	var raw_tiles: Dictionary = raw_level_data.tiles
	var player_start: Dictionary = raw_level_data.player_start
	
	add_tiles_for_layer(layout, TileLayers.LayerType.Floor, raw_tiles.Floor)
	add_tiles_for_layer(layout, TileLayers.LayerType.Walls, raw_tiles.Walls)
	add_tiles_for_layer(layout, TileLayers.LayerType.Targets, raw_tiles.Targets)
	add_tiles_for_layer(layout, TileLayers.LayerType.Boxes, raw_tiles.Boxes)
	add_tiles_for_layer(layout, TileLayers.LayerType.TargetBoxes, raw_tiles.TargetBoxes)
	
	layout.set_player_start(player_start.x, player_start.y)
	
	return layout


func load_level_data() -> void:
	var file: FileAccess = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	
	if !file:
		return
	
	var json_data: Dictionary = JSON.parse_string(file.get_as_text())
	for level_number in json_data.keys():
		var level_data = json_data[level_number]
		_level_data[level_number] = setup_level(level_number, level_data)


func get_level_data(level_number: String) -> LevelLayout:
	return _level_data[level_number]
