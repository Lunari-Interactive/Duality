extends Control


func _on_start_new_game_button_pressed():
	pass # Replace with function body.


func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Levels/UI/MainMenuLoadGame/LoadGame.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Assets/Levels/UI/MainMenuOptions/Options.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
