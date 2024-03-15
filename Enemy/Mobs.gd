extends Node2D

var Mob = preload("res://Enemy/Frog.tscn")
var counter = 0

# platform start,end = 600, 1300

func _on_timer_timeout():
	counter += 1
	var mob_tmp = Mob.instantiate()
	var rng = RandomNumberGenerator.new()
	var pos_x = rng.randi_range(200, 1800)
	mob_tmp.position = Vector2(pos_x, -5)
	mob_tmp.name = "Frog-" + str(counter)
	add_child(mob_tmp)
