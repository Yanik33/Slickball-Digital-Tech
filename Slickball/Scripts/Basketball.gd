extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if $RayCast2D.is_colliding():
		#$AnimatedSprite2D.play("bounce")
	#else:
		#$AnimatedSprite2D.play("normal")
		
	rotation = clamp(0,0,0)