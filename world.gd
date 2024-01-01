extends Node2D


func _ready():
	var paused_label = get_node("../World/UI/Paused")
	paused_label.visible = false
