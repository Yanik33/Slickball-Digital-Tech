extends Control



func _ready():
	pass 



func _process(delta):
	pass


func _on_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenese/MainMenu.tscn")
