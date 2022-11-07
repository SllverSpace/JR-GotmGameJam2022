extends Control

var updated = 0
var updating = false
var refreshTimer = 0
var lastUsername = Global.data["username"]

func _ready():
	$Username.text = Global.data["username"]
	
	for time in Global.leaderboard:
		$leaderboard.add_item(Global.usernames[time.properties["id"]], null, false)
		$leaderboard.add_item(str(round(time.value*100)/100), null, false)
	var leaderboard2 = GotmLeaderboard.new()
	leaderboard2.name = "time"
	leaderboard2.is_inverted = true
	leaderboard2.is_unique = true
	Global.leaderboard = yield(leaderboard2.get_scores(), "completed")
	$leaderboard.clear()
	for time in Global.leaderboard:
		$leaderboard.add_item(Global.usernames[time.properties["id"]], null, false)
		$leaderboard.add_item(str(round(time.value*100)/100), null, false)

func _process(delta):
	$GhostMansion.position = -get_global_mouse_position()/32+Vector2(256, 160)
	if $Username.text != Global.data["username"]:
		updated = 0.5
		Global.data["username"] = $Username.text
	else:
		updated -= delta
	if updated <= 0 and $Username.text != lastUsername:
		lastUsername = $Username.text
		updating = true
		yield(GotmScore.update(Global.scores[Global.id], 0, {"id": str(Global.id), "username": Global.data["username"]}), "completed")
		updating = false
		
	refreshTimer += delta
	if refreshTimer >= 2:
		refreshTimer = 0
		Global.scores = {}
		Global.usernames = {}
		var usernames2 = yield(Global.getLeaderboard("usernames"), "completed")
		var ids = []
		for score in usernames2:
			ids.append(score.properties["id"])
			Global.scores[score.properties["id"]] = score
			Global.usernames[score.properties["id"]] = score.properties["username"]
		
		var leaderboard2 = GotmLeaderboard.new()
		leaderboard2.name = "time"
		leaderboard2.is_inverted = true
		leaderboard2.is_unique = true
		Global.leaderboard = yield(leaderboard2.get_scores(), "completed")
		$leaderboard.clear()
		for time in Global.leaderboard:
			$leaderboard.add_item(Global.usernames[time.properties["id"]], null, false)
			$leaderboard.add_item(str(round(time.value*100)/100), null, false)

func _on_Back_pressed():
	Transition.switchScene("res://Scenes/Menu.tscn")
