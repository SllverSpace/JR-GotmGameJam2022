extends Control

var muted = true

func _ready():
	muted = Global.data["Muted"]

func _on_Play_pressed():
	Transition.switchScene("res://Scenes/outside.tscn")

func _process(delta):
	if not muted:
		if not Music.playing:
			Music.playing = true
	else:
		Music.playing = false
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(512, 320)

func _on_Info__Controls_pressed():
	Transition.setMsg("red", "")
	Transition.switchScene("res://Scenes/info.tscn")

func _on_Mute_pressed():
	muted = not muted
	Global.data["Muted"] = muted
