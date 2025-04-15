extends Node


const LEVEL = preload("res://scenes/level/level.tscn")
const MAIN = preload("res://scenes/main/main.tscn")


var _level_selected: String = "1"


func get_level_selected() -> String:
	return _level_selected


func load_level_scene(level_number: String) -> void:
	_level_selected = level_number
	get_tree().change_scene_to_packed(LEVEL)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
