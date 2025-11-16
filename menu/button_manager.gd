extends Control
@onready var sfx_click: AudioStreamPlayer = $sfx_click



func _on_start_pressed():
	sfx_click.play()
	get_tree().change_scene_to_file("res://levels/level.tscn")

func _on_quit_pressed():
	sfx_click.play()
	get_tree().quit()
	
