extends Node

const START_PLAYER_HP = 5
const START_EXPERIENCE = 0
const START_LEVEL = 1
const EXPERIENCE_TO_LEVEL = {1: 5, 2:20, 3:40, 4:70}
const START_JUMPS =2
const START_DASHES =1
const START_SPEED = 150.0

var player_hp = START_PLAYER_HP
var experience = START_EXPERIENCE
var level = START_LEVEL

# Upgradeable player stats
var max_speed = START_SPEED
var max_dashes = START_DASHES
var max_jumps = START_JUMPS


func add_exp(added_experience=1):
	experience += added_experience


func upgrade_stat(stat):
	if stat == "max_jumps":
		max_jumps += 1
	elif stat == "max_speed":
		max_speed += 30
	elif stat == "max_dashes":
		max_dashes += 1
