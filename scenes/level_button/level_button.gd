extends NinePatchRect


class_name LevelButton


@onready var level_label: Label = $LevelLabel


var _level_number: String = "0"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = _level_number


func setup(level_number: String) -> void:
	_level_number = level_number
