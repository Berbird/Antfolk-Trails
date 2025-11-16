extends CharacterBody2D

var interaction = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		interaction = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		interaction = true
