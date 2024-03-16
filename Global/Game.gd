extends Node

const START_PLAYER_HP = 5
const START_EXPERIENCE = 0
const START_LEVEL = 1
const EXPERIENCE_TO_LEVEL = {1: 5, 2:20, 3:40, 4:70}

var player_hp = START_PLAYER_HP
var experience = START_EXPERIENCE
var level = START_LEVEL

# Upgradeable player stats
var max_speed = 150.0
var max_dashes = 1
var max_jumps = 2

#func level_up():
	#print("Level up!")
	#level += 1
	#Utils.toggle_pause()
	#$UI/LevelUpMenu.visible = true

func add_exp(added_experience=1):
	experience += added_experience
	#if experience > EXPERIENCE_TO_LEVEL[level]:
		#level_up()


func upgrade_stat(stat):
	if stat == "max_jumps":
		max_jumps += 1
	elif stat == "max_speed":
		max_speed += 30
	elif stat == "max_dashes":
		max_dashes += 1
