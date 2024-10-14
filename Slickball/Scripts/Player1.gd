extends CharacterBody2D

var rand = RandomNumberGenerator.new()

@export var ball_scene : PackedScene

var hoop_vector
var intital_horizontal_velocity
var shot_verticle = 950

@onready var ball_placement = $Marker2D/Sprite2D/ball_placement
@onready var shoot_point = $Marker2D/Sprite2D/shoot_point

const SPEED = 400
const JUMP_VELOCITY = -500

var ball
var shot_reverse = false

@onready var hoop = get_node("/root/Node2D/P1_Hoop")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Path2D.hide()
	
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("P1_push"):
		collision_layer = 2
		collision_mask = 2
		if Input.is_action_just_pressed("P1_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY * 1.1
	elif Input.is_action_just_pressed("P1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		collision_layer = 1
		collision_mask = 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("P1_left", "P1_right")
	if direction and not Input.is_action_pressed('P1_push'):
		velocity.x = direction * SPEED
		$Marker2D.scale.x = -direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("P1_Shoot"):
		$Path2D.show()
		if not shot_reverse:
			if $Path2D/shot_indicator.progress_ratio < 0.98:
				$Path2D/shot_indicator.progress_ratio += 0.02
			else:
				shot_reverse = true
		elif shot_reverse:
			if $Path2D/shot_indicator.progress_ratio > 0.02:
				$Path2D/shot_indicator.progress_ratio -=0.02
			else:
				shot_reverse = false
	if Input.is_action_just_pressed("P1_Shoot"):
		$Path2D/PathFollow2D.progress_ratio = randf_range(0.10,0.85)
		
	if Input.is_action_just_released("P1_Shoot"):
		if $Path2D/shot_indicator.progress > $Path2D/PathFollow2D.progress - $Path2D/PathFollow2D/ColorRect.size.x / 2 and $Path2D/shot_indicator.progress < $Path2D/PathFollow2D.progress + $Path2D/PathFollow2D/ColorRect.size.x / 2:
			_shoot(true)
		else:
			_shoot(false)
		await get_tree().create_timer(1.0).timeout
		$Path2D.hide()
		
		
	
		
	
	
	
	move_and_slide()
	
	
func _shoot(perfect):
	if perfect:
		hoop_vector = (ball_placement.global_position - get_node("/root/Node2D/P1_Hoop").global_position) + Vector2(rand.randf_range(0, 0), 0)
	elif not perfect:
		hoop_vector = (ball_placement.global_position - get_node("/root/Node2D/P1_Hoop").global_position) + Vector2(rand.randf_range(-150, 150), 0)
	var discriminant = shot_verticle**2 - 2 * gravity * hoop_vector.y;
	intital_horizontal_velocity = -hoop_vector.x / ((-shot_verticle - (discriminant**0.5))/-gravity)	
	if ball_placement.remote_path != NodePath(""):
		ball_placement.remote_path = NodePath("")
		ball.held = false
		ball.thrown = true
		ball.linear_velocity.y = -shot_verticle
		ball.linear_velocity.x = intital_horizontal_velocity
	



func _on_area_2d_body_entered(body):
	if body.has_meta("ball"):
		ball = body
		if not ball.held:
			if ball_placement.remote_path == NodePath(""):
				ball_placement.remote_path = ball.get_path()
				ball.held = true
