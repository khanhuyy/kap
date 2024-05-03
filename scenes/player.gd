extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d = $AnimatedSprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			animated_sprite_2d.play("jump")
		if velocity.y < 0:
			animated_sprite_2d.play("fall")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	# move
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite_2d.play("idle")

	# change animation direction
	
	move_and_slide()
