extends CanvasLayer

var timer = 0
var runningTimer = true

func _process(delta):
	if runningTimer:
		timer += delta
	$Time.text = str(round(timer*100)/100)

func stopTimer():
	runningTimer = false
