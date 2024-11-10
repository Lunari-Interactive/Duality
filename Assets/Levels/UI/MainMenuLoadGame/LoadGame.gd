extends Control

var roomID




func _on_load_local_level_pressed():
	var main_menu_music = get_node_or_null("/root/MenuMusic")
	if main_menu_music:
		main_menu_music.stop()
		main_menu_music.queue_free()
	else:
		print("MenuMusic node not found!")
	get_tree().change_scene_to_file("res://Assets/Levels/Level1.tscn")


func _on_set_room_id_pressed() -> void:
	pass # Join(roomID)


func _on_line_edit_text_submitted(new_text: String) -> void:
	roomID = new_text


func _on_back_to_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Levels/MainMenu.tscn")
