extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var dead = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
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



func death():
	dead = true
	chase = false
	Game.gold += 5
	Utils.save_game()
	call_deferred("_disable_collision")

func _on_player_death_body_entered(body):
	if body.name == "Player":
		if not dead:
			body.bounce()
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
