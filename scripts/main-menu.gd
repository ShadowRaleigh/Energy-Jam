extends VBoxContainer


func _on_startbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fazenda.tscn")


func _on_quitbutton_pressed() -> void:
	get_tree().quit()
