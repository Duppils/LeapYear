extends Node2D


func _ready():
	var paused_label = get_node("../World/UI/Paused")
	paused_label.visible = false

func level_up():
	print("Level up!")
	Game.level += 1
	Utils.toggle_pause()
	$UI/LevelUp.visible = true
#
#func add_exp(exp=1):
	#Game.experience += exp
	#if Game.experience > Game.EXPERIENCE_TO_LEVEL[Game.level]:
		#level_up()
#
#
#func upgrade_stat(stat):
	#if stat == "max_jumps":
		#Game.max_jumps += 1
	#elif stat == "max_speed":
		#Game.max_speed += 30
	#elif stat == "max_dashes":
		#Game.max_dashes += 1
