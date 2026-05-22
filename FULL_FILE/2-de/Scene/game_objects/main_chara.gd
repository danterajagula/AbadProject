extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -900.0

@onready var sprite_2d = $Sprite2D
@export var particle : PackedScene

# Get the gravity from the project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

func jump():
	velocity.y = JUMP_VELOCITY
	spawn_particles()

func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

func _physics_process(delta):

	# Add gravity
	if is_on_floor():
		jump_count = 0
		
		#animtion
		if (velocity.x > 1 || velocity.x < -1):
			sprite_2d.animation = "Running"
		else:
			sprite_2d.animation = "Default"
		
	else:
		velocity.y += gravity * delta
		if (jump_count == 2):
			sprite_2d.animation = "Double_jumping"
		else:
			sprite_2d.animation = "Jumping"
			
	# Jump
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		if (jump_count == 2):
			spawn_particles()

	# Movement
	var direction = Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 15)

	# Flip sprite
	var is_left = velocity.x < 0
	sprite_2d.flip_h = is_left

	move_and_slide()

func spawn_particles():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()
