extends CharacterBody2D

@export var ball_scene : PackedScene

var hoop_vector
var intital_horizontal_velocity
var shot_verticle = 900

const SPEED = 400
const JUMP_VELOCITY = -500

@onready var hoop = get_node("/root/Node2D/P2_Hoop")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("P2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("P2_left", "P2_right")
	if direction and not Input.is_action_pressed('P2_push'):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("P2_Shoot"):
		_shoot()
	
	hoop_vector = $shoot_point2.global_position - get_node("/root/Node2D/P2_Hoop").global_position
	
	var discriminant = shot_verticle**2 - 2 * gravity * hoop_vector.y;
	intital_horizontal_velocity = -hoop_vector.x / ((-shot_verticle - (discriminant**0.5))/-gravity)	
	
	move_and_slide()
	
	
func _shoot():
	var ball = ball_scene.instantiate()
	ball.global_position = $shoot_point2.global_position
	ball.linear_velocity.y = -shot_verticle
	ball.linear_velocity.x = intital_horizontal_velocity
	add_sibling(ball)
