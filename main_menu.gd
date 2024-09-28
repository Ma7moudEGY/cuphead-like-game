extends Control


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/about_me.tscn")
	
func _on_exit_pressed() -> void:
	get_tree().quit()
