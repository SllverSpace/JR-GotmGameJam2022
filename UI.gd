extends CanvasLayer

var timer = 0

func _process(delta):
	timer += delta
	$Time.text = str(round(timer*100)/100)
