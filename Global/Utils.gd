extends Node

var SAVE_PATH = "res://savegame.bin" # change res to user in most cases

var paused = false

func _ready():
	# Listen to these scripts even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	

func reset_player():
	Game.player_hp = Game.START_PLAYER_HP
	Game.experience = Game.START_EXPERIENCE
	Game.level = Game.START_LEVEL
	Game.max_jumps = Game.START_JUMPS
	Game.max_dashes = Game.START_DASHES
	Game.max_speed = Game.START_SPEED

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"player_hp": Game.player_hp,
		"experience": Game.experience,
		"level": Game.level,
		"max_jumps": Game.max_jumps,
		"max_speed": Game.max_speed,
		"max_dashes": Game.max_dashes,
	}
	var json_data = JSON.stringify(data)
	file.store_line(json_data)
	
func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.player_hp = current_line["player_hp"]
				Game.experience = current_line["experience"]
				Game.level = current_line["level"]
				Game.max_jumps = current_line["max_jumps"]
				Game.max_speed = current_line["max_speed"]
				Game.max_dashes = current_line["max_dashes"]
		
func toggle_pause():
	paused = not paused
	get_tree().paused = paused
	var paused_label = get_node("../World/UI/Paused")
	paused_label.visible = paused
				
func _input(_ev):
	if Input.is_action_just_pressed("ui_pause"):
		toggle_pause()
