extends CharacterBody2D

const SPEED = 185.0
const JUMP_VELOCITY = -400.0
const DASH_VELOCITY = 600
const DASH_RANGE = 1000
const MAX_JUMPS = 2
const acceleration = 10
const MAX_DASHES = 1

var jumps = 0

var dash_start_x = 0
var dashes = 0
var dashing = false
var dashTime = 0.2 # Adjust this value to control the duration of the dash
var dashTimer = 0.0

var exp = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")

func bounce(bounce_modifier=1):
	velocity.y += JUMP_VELOCITY*bounce_modifier
	# NOTE: $NodeName is an alternative to get_node("NodeName")
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		jumps = 0
		dashes = 0
	else:
		velocity.y += gravity * delta
		
	if dashing:
		# Increment the timer
		dashTimer += delta
		# Check if the dash duration has elapsed
		if dashTimer >= dashTime:
			# End the dash
			dashing = false
			velocity.x = velocity.x/5
	elif Input.is_action_just_pressed("ui_accept") and jumps < MAX_JUMPS:
		$AudioStreamPlayer2D.play()
		jumps += 1
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("dash_left"):
		if dashes < MAX_DASHES:
			dashes += 1
			dashing = true
			dashTimer = 0.0
			var targetVelocity = -1 * DASH_VELOCITY
			velocity.x = targetVelocity
	elif Input.is_action_just_pressed("dash_right"):
		if dashes < MAX_DASHES:
			dashes += 1
			dashing = true
			dashTimer = 0.0
			var targetVelocity = 1 * DASH_VELOCITY
			velocity.x = targetVelocity
	else:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction == -1:
			sprite.flip_h = true
		elif direction == 1:
			sprite.flip_h = false
		
		var speed = min(abs(velocity.x) + acceleration, SPEED)
		if direction:
			velocity.x = direction * speed
			anim.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			if velocity.y == 0:
				anim.play("Idle")
			
		
	if velocity.y < 0:
		anim.play("Jump")
	elif velocity.y > 0:
		anim.play("Fall")
		

	move_and_slide()
	
	if Game.player_hp <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
		
		
