extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MAX_JUMPS = 2
const acceleration = 15

var jumps = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")
@onready var sprite = get_node("AnimatedSprite2D")

func bounce():
	velocity.y += JUMP_VELOCITY
	# NOTE: $NodeName is an alternative to get_node("NodeName")
	$AudioStreamPlayer2D.play()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		jumps = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumps < MAX_JUMPS:
		$AudioStreamPlayer2D.play()
		jumps += 1
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	#print(direction)
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
		
		
