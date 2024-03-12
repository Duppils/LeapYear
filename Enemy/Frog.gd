extends CharacterBody2D

const SPEED = 80
const MAX_TIME_IN_WATER = 5

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 200
var player
var chase = false
var dead = false
var swimming = false
var time_in_water = 0

var bounce_modifier = 1


func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	if swimming:
		time_in_water += delta
		
	if time_in_water > MAX_TIME_IN_WATER:
		death(false)
		
	var anim = get_node("AnimatedSprite2D")
	if anim.animation == "Death":
		return
	velocity.y += gravity + delta
	if chase == true:
		anim.play("Jump")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * SPEED
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = false
	else:
		velocity.x = 0
		anim.play("Idle")
	
	move_and_slide()

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
			Game.gold += 5
			Game.experience += 1
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
			Game.player_hp -= 1
			death()
