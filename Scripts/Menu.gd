extends Control

var muted = true

func _ready():
	muted = Global.data["muted"]

func _on_Play_pressed():
	Transition.switchScene("res://Scenes/outside.tscn")

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(256, 160)
	if muted:
		$Mute.text = " Unmute "
	else:
		$Mute.text = " Mute "

func _on_Info__Controls_pressed():
	Transition.setMsg("red", "")
	Transition.switchScene("res://Scenes/info.tscn")

func _on_Mute_pressed():
	muted = not muted
	Global.data["muted"] = muted

func _on_Leaderboard_pressed():
	Transition.setMsg("red", "")
	Transition.switchScene("res://Scenes/leaderboard.tscn")
