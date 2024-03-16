extends Node2D

var timer
var initial_wait_time = 3.0
var decrease_rate = 0.1
var min_wait_time = 0.3

var Mob = preload("res://Enemy/Frog.tscn")
var counter = 0

func _ready():
	timer = $Timer
	timer.start(initial_wait_time)


func update_timer():
	timer.wait_time -= decrease_rate
	if timer.wait_time < min_wait_time:
		timer.wait_time = min_wait_time

	timer.start(timer.wait_time)


func _on_timer_timeout():
	counter += 1
	var mob_tmp = Mob.instantiate()
	var rng = RandomNumberGenerator.new()
	var pos_x = rng.randi_range(300, 1200)
	mob_tmp.position = Vector2(pos_x, -5)
	mob_tmp.name = "Frog-" + str(counter)
	add_child(mob_tmp)
	
	update_timer()

	
