extends CharacterBody2D

var rand = RandomNumberGenerator.new()

@export var ball_scene : PackedScene

var hoop_vector
var intital_horizontal_velocity
var shot_verticle = 1000

@onready var ball_placement2 = $Marker2D/Sprite2D/ball_placement2
@onready var shoot_point2 = $Marker2D/Sprite2D/shoot_point2

const SPEED = 400
const JUMP_VELOCITY = -500

var ball

@onready var hoop = get_node("/root/Node2D/P2_Hoop")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("P2_push"):
		collision_layer = 1
		collision_mask = 1
		if Input.is_action_just_pressed("P2_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY * 1.1
	elif Input.is_action_just_pressed("P2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		collision_layer = 2
		collision_mask = 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("P2_left", "P2_right")
	if direction and not Input.is_action_pressed('P2_push'):
		velocity.x = direction * SPEED
		$Marker2D.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("P2_Shoot"):
		_shoot()
	
	hoop_vector = (shoot_point2.global_position - get_node("/root/Node2D/P2_Hoop").global_position) + Vector2(rand.randf_range(-150, 150), 0)
	
	var discriminant = shot_verticle**2 - 2 * gravity * hoop_vector.y;
	intital_horizontal_velocity = -hoop_vector.x / ((-shot_verticle - (discriminant**0.5))/-gravity)	
	
	move_and_slide()
	
	
func _shoot():
	if ball_placement2.remote_path != NodePath(""):
		ball_placement2.remote_path = NodePath("")
		ball.held = false
		ball.thrown = true
		ball.linear_velocity.y = -shot_verticle
		ball.linear_velocity.x = intital_horizontal_velocity
	


func _on_area_2d_body_entered(body):
	if body.has_meta("ball"):
		ball = body
		if not ball.held:
			if ball_placement2.remote_path == NodePath(""):
				ball_placement2.remote_path = ball.get_path()
				ball.held = true
