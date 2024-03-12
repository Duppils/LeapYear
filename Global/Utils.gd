extends Node

var SAVE_PATH = "res://savegame.bin" # change res to user in most cases

var paused = false

func _ready():
	# Listen to these scripts even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"player_hp": Game.player_hp,
		"exp": Game.exp
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
				Game.exp = current_line["exp"]
		
func toggle_pause():
	paused = not paused
	get_tree().paused = paused
	var paused_label = get_node("../World/UI/Paused")
	paused_label.visible = paused
				
func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		toggle_pause()
