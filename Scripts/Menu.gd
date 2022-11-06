extends Control

func _on_Play_pressed():
	Transition.switchScene("res://Scenes/outside.tscn")

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(512, 320)

func _on_Info__Controls_pressed():
	Transition.setMsg("red", "")
	Transition.switchScene("res://Scenes/info.tscn")
