extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_button_pressed():
	Game.upgrade_stat("max_jumps")
	visible = false
	Utils.toggle_pause()


func _on_button_2_pressed():
	Game.upgrade_stat("max_speed")
	visible = false
	Utils.toggle_pause()


func _on_button_3_pressed():
	Game.upgrade_stat("max_dashes")
	visible = false
	Utils.toggle_pause()

