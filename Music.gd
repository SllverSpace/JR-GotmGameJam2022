extends AudioStreamPlayer

var timer = 0

func _process(delta):
	timer += delta
	if timer > 1:
		if not Global.data["muted"]:
			if not Music.playing:
				Music.playing = true
		else:
			Music.playing = false
