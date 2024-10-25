extends RigidBody2D

#Ball Held
var held = false

#Ball Thrown
var thrown = false

#ScoreBoard
@onready var scoreboard = get_node("/root/Node2D/CanvasLayer")


 


func _physics_process(delta):
	if held:
		$AnimatedSprite2D.play("bounce")
	else :
		$AnimatedSprite2D.play("normal")

	



func _on_area_2d_area_entered(area):
	if area.has_meta("scorep1"):
		scoreboard._update_scoreboard(true, false)
		print("SCORE Player 1")
	if area.has_meta("scorep2"):
		scoreboard._update_scoreboard(false, true)
		print("SCORE Player 2")
		




