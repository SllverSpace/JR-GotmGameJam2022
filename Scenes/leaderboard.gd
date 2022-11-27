extends Control

var updated = 0
var updating = false
var lastUsername = Global.data["username"]

func reload():
	$leaderboard.clear()
	for time in Global.leaderboard:
		$leaderboard.add_item(Global.usernames[time.properties["id"]], null, false)
		$leaderboard.add_item(str(round(-time.value*100)/100), null, false)

func _ready():
	Global.connect("refreshed", self, "reload")
	
	if str(Global.data["besttime"]) != "Unknown":
		$"Best Time".text = "Best Time: " + str(round(-Global.data["besttime"]*100)/100)
	else:
		$"Best Time".text = "Best Time: Unknown"
	$Username.text = Global.data["username"]
	
	reload()

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(256, 160)
	if $Username.text != Global.data["username"]:
		updated = 0.5
		Global.data["username"] = $Username.text
	else:
		updated -= delta
	if updated <= 0 and $Username.text != lastUsername and Global.scores.has(Global.id):
		lastUsername = $Username.text
		updating = true
		yield(GotmScore.update(Global.scores[Global.id], 0, {"id": str(Global.id), "username": Global.data["username"]}), "completed")
		updating = false

func _on_Back_pressed():
	if not updating:
		Transition.switchScene("res://Scenes/Menu.tscn")

func _on_Expand_pressed():
	Global.fullLeaderboard = not Global.fullLeaderboard
	if Global.fullLeaderboard:
		$Expand.text = " Compact "
	else:
		$Expand.text = "Expand"
