extends Node2D


const SOURCE_ID: int = 0


@onready var tile_layers: Node2D = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/Floor
@onready var walls_tiles: TileMapLayer = $TileLayers/Walls
@onready var targets_tiles: TileMapLayer = $TileLayers/Targets
@onready var boxes_tiles: TileMapLayer = $TileLayers/Boxes
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: AnimatedSprite2D = $Player


var _tile_size: int = 0
var _player_tile: Vector2i = Vector2i.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		GameManager.load_main_scene()
	if event.is_action_pressed("reload"):
		get_tree().reload_current_scene()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Level Loaded: ", GameManager.get_level_selected())
	_tile_size = floor_tiles.tile_set.tile_size.x
	setup_level()


func place_player_on_tile(tile_coord: Vector2i) -> void:
	player.position = Vector2(tile_coord * _tile_size)
	_player_tile = tile_coord


func get_atlas_coord(lt: TileLayers.LayerType) -> Vector2i:
	match lt:
		TileLayers.LayerType.Walls:
			return Vector2i(6,7)
		TileLayers.LayerType.Floor:
			return Vector2i(11,6)
		TileLayers.LayerType.Targets:
			return Vector2i(12,4)
		TileLayers.LayerType.TargetBoxes:
			return Vector2i(9,0)
		TileLayers.LayerType.Boxes:
			return Vector2i(6,0)
		_:
			return Vector2i.ZERO


func add_tile(lt: TileLayers.LayerType, tc: Vector2i, map: TileMapLayer) -> void:
	var atlas_coord: Vector2i = get_atlas_coord(lt)
	map.set_cell(tc, SOURCE_ID, atlas_coord)


func setup_layer(lt: TileLayers.LayerType, map: TileMapLayer, ll: LevelLayout) -> void:
	var tiles: Array[Vector2i] = ll.get_tiles_for_layer(lt)
	for tc in tiles:
		add_tile(lt, tc, map)


func clear_tiles() -> void:
	for tl in tile_layers.get_children():
		tl.clear()


func move_camera() -> void:
	var tmr: Rect2i = floor_tiles.get_used_rect()
	camera_2d.position = tmr.get_center() * _tile_size


func setup_level() -> void:
	var level_number: String = GameManager.get_level_selected()
	var level_layout: LevelLayout = LevelData.get_level_data(level_number)
	clear_tiles()
	
	setup_layer(TileLayers.LayerType.Floor, floor_tiles, level_layout)
	setup_layer(TileLayers.LayerType.Walls, walls_tiles, level_layout)
	setup_layer(TileLayers.LayerType.Targets, targets_tiles, level_layout)
	setup_layer(TileLayers.LayerType.Boxes, boxes_tiles, level_layout)
	setup_layer(TileLayers.LayerType.TargetBoxes, boxes_tiles, level_layout)
	
	place_player_on_tile(level_layout.get_player_start())
	
	move_camera()
