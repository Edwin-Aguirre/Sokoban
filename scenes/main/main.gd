extends Control


const LEVELS_COUNT = 30
const LEVEL_BUTTON = preload("res://scenes/level_button/level_button.tscn")

@onready var grid_container: GridContainer = $MC/VB/GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid()


func setup_grid() -> void:
	for level in range(LEVELS_COUNT):
		var level_button: LevelButton = LEVEL_BUTTON.instantiate()
		level_button.setup(str(level+1))
		grid_container.add_child(level_button)
