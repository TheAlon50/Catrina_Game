extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Center/Label.text = " [center][wave]GAME OVER
¿ESTE ES TU FINAL?[/wave][/center]"


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Escenas/menu/portada.tscn")
