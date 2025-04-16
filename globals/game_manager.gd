extends Node


const LEVEL = preload("res://scenes/level/level.tscn")
const MAIN = preload("res://scenes/main/main.tscn")


var _level_selected: String = "1"
var _best_scores: HighScoresResource


func get_best_score(level: String) -> int:
	return _best_scores.get_best_score(level)


func _enter_tree() -> void:
	_best_scores = HighScoresResource.load_scores()


func has_level_score(level: String) -> bool:
	return _best_scores.has_level_score(level)


func level_completed(level: String, score: int) -> bool:
	return _best_scores.add_score(level, score)


func get_level_selected() -> String:
	return _level_selected


func load_level_scene(level_number: String) -> void:
	_level_selected = level_number
	get_tree().change_scene_to_packed(LEVEL)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(MAIN)
