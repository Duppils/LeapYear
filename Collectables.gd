extends Node2D

var Cherry = preload("res://Collectables/cherry.tscn")


func _on_timer_timeout():
	var cherry_tmp = Cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	var pos_x = rng.randi_range(10, 2000)
	cherry_tmp.position = Vector2(pos_x, 400)
	add_child(cherry_tmp)
