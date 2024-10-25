extends Control



func _ready():
	pass 



func _process(delta):
	pass


func _on_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/Main_Scene.tscn")


func _on_control_buttons_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/controls.tscn")


func _on_credits_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/credits.tscn")
