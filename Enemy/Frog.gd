extends CharacterBody2D

const SPEED = 80
const MAX_TIME_IN_WATER = 10

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 200
var player
var chase = false
var dead = false
var swimming = false
var time_in_water = 0

var bounce_modifier = 1.5


@onready var nav_agent := $Navigator/NavigationAgent2D as NavigationAgent2D


func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	player = get_node("../../Player/Player")
	

func makepath():
	nav_agent.target_position = player.global_position

func _physics_process(delta):
	if swimming:
		time_in_water += delta
		
	if time_in_water > MAX_TIME_IN_WATER:
		death(false)
		
	var anim = get_node("AnimatedSprite2D")
	if anim.animation == "Death":
		return
		
	# Start navigation to player	
	var dir_x = to_local(nav_agent.get_next_path_position()).normalized().x
	velocity.x = dir_x * SPEED 
	velocity.y += gravity + delta
	
	if abs(dir_x) < 0.05:
		if dir_x < 0:
			position.x -= 8
		elif dir_x > 0:
			position.x += 8
	
	if dir_x > 0:
		get_node("AnimatedSprite2D").flip_h = true
	elif dir_x < 0:
		get_node("AnimatedSprite2D").flip_h = false
	
	
	anim.play("Jump")
	
	move_and_slide()
		#anim.play("Idle")

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func death(killed=true):
	if not dead:
		dead = true
		chase = false
		if killed:
			Game.add_exp(1)
		Utils.save_game()
		call_deferred("_disable_collision")

func _on_player_death_body_entered(body):
	if body.name == "Player":
		if not dead:
			body.bounce(bounce_modifier)
			death()

func _disable_collision():
	get_node("CollisionShape2D").disabled = true
	get_node("PlayerDeath/CollisionShape2D").disabled = true
	get_node("PlayerCollision/CollisionShape2D").disabled = true
	
	var anim = get_node("AnimatedSprite2D")
	anim.play("Death")
	await anim.animation_finished
	self.queue_free()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if not dead:
			body.take_hit()
			death()


func _on_timer_timeout():
	makepath()
