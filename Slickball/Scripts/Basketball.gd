extends RigidBody2D

var held = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if held:
		$AnimatedSprite2D.play("bounce")
	else :
		$AnimatedSprite2D.play("normal")

		
	#rotation = clamp(0,0,0)



func _on_area_2d_area_entered(area):
	if area.has_meta("scorep1"):
		print("SCORE Player 1")
	if area.has_meta("scorep2"):
		print("SCORE Player 2")	

