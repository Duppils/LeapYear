extends Node2D

var Mob = preload("res://Enemy/Frog.tscn")

func _on_timer_timeout():
	var mob_tmp = Mob.instantiate()
	var rng = RandomNumberGenerator.new()
	var pos_x = rng.randi_range(10, 2000)
	mob_tmp.position = Vector2(pos_x, 10)
	add_child(mob_tmp)
