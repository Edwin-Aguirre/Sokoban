extends NinePatchRect


class_name LevelButton


const BUTTON_SQUARE_DEPTH_FLAT = preload("res://assets/ui/button_square_depth_flat.png")
const BUTTON_SQUARE_DEPTH_GRADIENT = preload("res://assets/ui/button_square_depth_gradient.png")


@onready var level_label: Label = $LevelLabel


var _level_number: String = "0"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = _level_number


func setup(level_number: String) -> void:
	_level_number = level_number


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		GameManager.load_level_scene(_level_number)


func _on_mouse_entered() -> void:
	texture = BUTTON_SQUARE_DEPTH_GRADIENT


func _on_mouse_exited() -> void:
	texture = BUTTON_SQUARE_DEPTH_FLAT
