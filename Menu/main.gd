extends Node2D



func _on_continue_pressed():
	Utils.load_game()
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_new_game_pressed():
	Utils.reset_player()
	Utils.save_game()
	get_tree().change_scene_to_file("res://World/world.tscn")


func _on_quit_pressed():
	get_tree().quit()

