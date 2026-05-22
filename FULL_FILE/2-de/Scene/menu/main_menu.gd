extends Node


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scene/levels/Level1.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Scene/levels/Level2.tscn")
