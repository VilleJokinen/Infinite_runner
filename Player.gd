class_name Player
extends KinematicBody

signal obstacle_hit

# Player movement
var sidestep_speed := 5.0
var run_speed: float
var gravity: float
var jump_speed: float

var velocity := Vector3()

# Bobbing animation
var time: float = 0.0
var step_freq: float = 2.0
var step_height: float = 0.2
var step_tilt: float = 8.0  # degrees

# References to nodes
onready var body_hinge = $BodyHinge


# Given jump length, jump height and horizontal speed, calculates gravity and initial jump speed
func setup_jump(length: float, height: float, speed: float):
	# source: YouTube - "Math for Game Programmers: Building a Better Jump"
	# https://www.youtube.com/watch?v=hG9SzQxaCm8
	gravity = 8.0 * height * speed * speed / (length * length)
	jump_speed = 4.0 * height * speed / length
	run_speed = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Player animation (while on ground)
	if is_on_floor():
		body_hinge.translation.y = step_height * (1 + sin(2.0 * PI * step_freq * time))
		body_hinge.rotation_degrees.z = step_tilt * sin(PI * step_freq * time)
		time += delta
	
	# Sideways movement
	var sideways: float = 0.0
	if Input.is_action_pressed("move_right") and is_on_floor():
		sideways += 1.0
	if Input.is_action_pressed("move_left") and is_on_floor():
		sideways -= 1.0
	
	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	velocity.y -= gravity * delta
	velocity.x = sideways * sidestep_speed
	velocity.z = -run_speed
	velocity = move_and_slide(velocity, Vector3.UP)
	
	# Detect collisions
	for index in range(get_slide_count()):
		var collision = get_slide_collision(index)
		var collision_object = collision.collider as CollisionObject
		if collision_object.collision_layer & 4 and rad2deg(collision.get_angle()) > 60:
			# We're colliding with an obstacle
			emit_signal("obstacle_hit")
