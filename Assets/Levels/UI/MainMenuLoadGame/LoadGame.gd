extends Control

var roomID




func _on_load_local_level_pressed():
	pass # LoadLocalLevel.


func _on_set_room_id_pressed() -> void:
	pass # Join(roomID)


func _on_line_edit_text_submitted(new_text: String) -> void:
	roomID = new_text


func _on_back_to_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Levels/MainMenu.tscn")
