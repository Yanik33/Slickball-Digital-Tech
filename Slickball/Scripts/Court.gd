extends StaticBody2D

@export var p1_hoop : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _p1_hoop_scored(area):
	if area.has_meta("ball"):
		p1_hoop.play("Shot")
		


func _p1_shot_finished():
	if p1_hoop.animation == "Shot":
		p1_hoop.play("default")
