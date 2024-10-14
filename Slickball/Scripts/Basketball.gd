extends RigidBody2D

var held = false
var thrown = false
@onready var scoreboard = get_node("/root/Node2D/CanvasLayer")

# Called when the node enters the scene tree for the first time.
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if held:
		$AnimatedSprite2D.play("bounce")
	else :
		$AnimatedSprite2D.play("normal")

	if thrown:
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(0.3).timeout
		$CollisionShape2D.disabled = false
		thrown = false
	#rotation = clamp(0,0,0)



func _on_area_2d_area_entered(area):
	if area.has_meta("scorep1"):
		scoreboard._update_scoreboard(true, false)
		print("SCORE Player 1")
	if area.has_meta("scorep2"):
		scoreboard._update_scoreboard(false, true)
		print("SCORE Player 2")
		




