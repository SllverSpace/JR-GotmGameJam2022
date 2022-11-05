extends Control

func _on_Play_pressed():
	Transition.switchScene("res://outside.tscn")

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(512, 320)
	
