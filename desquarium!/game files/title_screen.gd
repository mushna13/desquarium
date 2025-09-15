extends Node2D
#new game
func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://gacha screen.tscn")

#load game
func _on_load_game_pressed() -> void:
	get_tree().change_scene_to_file("res://main_scene.tscn")
