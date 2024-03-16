extends Node2D


func _ready():
	var paused_label = get_node("../World/UI/Paused")
	paused_label.visible = false

func level_up():
	print("Level up!")
	Game.level += 1
	Utils.toggle_pause()
	$UI/LevelUp.visible = true
	$UI/LevelUp/MarginContainer/VBoxContainer/Button.grab_focus()


func _on_timer_timeout():
	if Game.experience > Game.EXPERIENCE_TO_LEVEL[Game.level]:
		level_up()
