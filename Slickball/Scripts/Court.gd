extends StaticBody2D

#player 1 hoop point
@export var p1_hoop : Node
#player 2 hoop point
@export var p2_hoop : Node


func _ready():
	pass 



func _process(delta):
	pass


func _p1_hoop_scored(area):
	if area.has_meta("ball"):
		p1_hoop.play("Shot")
		

func _p1_shot_finished():
	if p1_hoop.animation == "Shot":
		p1_hoop.play("default")
		




func _p2_hoop_scored(area):
	if area.has_meta("ball"):
		p2_hoop.play("Shot 2")
		

func _p2_hoop_finished():
	if p2_hoop.animation == "Shot 2":
		p2_hoop.play("default")


func _on_home_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/MainMenu.tscn")
