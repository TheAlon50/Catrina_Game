extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MariaJose(Player)":
		# Cambia de escena de forma segura
		call_deferred("cambiar_escena")

func cambiar_escena():
	get_tree().change_scene_to_file("res://Escenas/Winwin/win.tscn")
