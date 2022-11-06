extends Control

func _ready():
	#yield(get_tree().create_timer(0), "timeout")
	get_tree().change_scene("res://Scenes/Menu.tscn")
