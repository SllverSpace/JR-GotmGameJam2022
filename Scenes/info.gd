extends Control

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(512, 320)

func _on_Back_pressed():
	Transition.switchScene("res://Scenes/Menu.tscn")
