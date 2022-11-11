extends CanvasLayer

var animating = false
var scenePath2 = ""
var switching = false
var msg = ""

func _process(delta):
	animating = $AnimationPlayer.is_playing()

func setMsg(colour, text):
	msg = text
	$Transition/MessageRed.visible = colour == "red"
	$Transition/MessageGreen.visible = colour == "green"
	$Transition/MessageRed.text = text
	$Transition/MessageGreen.text = text

func switchScene(scenePath):
	scenePath2 = scenePath
	if switching:
		return
	switching = true
	if scenePath == "res://Scenes/outside.tscn":
		setMsg("red", "DON'T STOP RUNNING")
		
	close()
	yield(get_tree().create_timer(1), "timeout")
	UI.get_node("Time").visible = scenePath2 == "res://Scenes/outside.tscn"
	get_tree().change_scene(scenePath2)
	if msg == "DON'T STOP RUNNING" or msg == "YOU DIED":
		yield(get_tree().create_timer(0.75), "timeout")
	if "You Finished!" in msg:
		yield(GotmScore.create("time", UI.timer, {"id": str(Global.id)}), "completed")
		yield(get_tree().create_timer(2), "timeout")
	open()
	switching = false

func close():
	$AnimationPlayer.play("close")

func open():
	$AnimationPlayer.play("open")
	

