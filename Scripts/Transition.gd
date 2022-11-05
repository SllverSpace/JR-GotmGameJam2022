extends CanvasLayer

var animating = false

func _process(delta):
	animating = $AnimationPlayer.is_playing()

func switchScene(scenePath):
	close()
	while $AnimationPlayer.is_playing():
		yield(get_tree().create_timer(0), "timeout")
	get_tree().change_scene(scenePath)
	open()

func close():
	$AnimationPlayer.play("close")

func open():
	$AnimationPlayer.play("open")
	

