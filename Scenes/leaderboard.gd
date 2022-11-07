extends Control

func _ready():
	$Username.text = Global.data["username"]

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(256, 160)
	Global.data["username"] = $Username.text

func _on_Back_pressed():
	Transition.switchScene("res://Scenes/Menu.tscn")
