extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/Main_Scene.tscn")


func _on_control_buttons_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/controls.tscn")


func _on_credits_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/credits.tscn")
