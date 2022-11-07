extends Node

var aToZ = "abcdefghijklmnopqrstuvwxyzABCDEFFGHIJKLMNOPQRSTUVWXYZ"
var id = ""
var data = {}
var savedData = {}
var leaderboard = []
var scores = {}
var usernames = {}
var done = false
var fullLeaderboard = false
var defaultData = {
	"username": "Unnamed", "muted": false, "id": getId(10), "besttime": "Unknown"
}

signal refreshed

func refresh():
	var usernames3 = {}
	var scores3 = {}
	var leaderboard3 = yield(getLeaderboard("time"), "completed")
	done = false
	if not fullLeaderboard:
		var dupes = {}
		for score in leaderboard3:
			var id2 = score.properties["id"]
			if not dupes.has(id2):
				dupes[id2] = [score]
			else:
				dupes[id2].append(score)
		for dupe in dupes:
			var lowest = 0
			for score in dupes[dupe]:
				if score.value < lowest or lowest == 0:
					lowest = score.value
			if dupe == id:
				data["besttime"] = lowest
			for score in dupes[dupe]:
				if score.value != lowest:
					leaderboard3.remove(leaderboard3.find(score))
	
	var usernames2 = yield(getLeaderboard("usernames"), "completed")
	var ids = []
	for score in usernames2:
		ids.append(score.properties["id"])
		scores3[score.properties["id"]] = score
		usernames3[score.properties["id"]] = score.properties["username"]
	leaderboard = leaderboard3.duplicate(true)
	scores = scores3.duplicate(true)
	usernames = usernames3.duplicate(true)
	done = true
	emit_signal("refreshed")

func _ready():
	var config = GotmConfig.new()
	config.project_key = "authenticators/GAg8PUqTDFZzLlagDuRB"
	config.beta_unsafe_force_global_scores = true
	config.beta_unsafe_force_global_contents = true
	config.beta_unsafe_force_global_marks = true
	Gotm.initialize(config)
	
	var data2 = SaveLoad.loadData("thebois34-ghost-mansion.data")
	if data2.has("id"):
		id = data2["id"]
		data = data2.duplicate(true)
		for key in data:
			if not defaultData.has(key):
				data.erase(key)
		for key in defaultData:
			if not data.has(key):
				data[key] = defaultData[key]
	else:
		id = Global.getId(10)
		data = defaultData.duplicate(false)
		SaveLoad.saveData("thebois34-ghost-mansion.data", {"id": id, "Username": "Unnamed", "Muted": false})
	savedData = data.duplicate(true)
	
	if not data["muted"]:
		yield(get_tree().create_timer(0.5), "timeout")
		Music.playing = false
		yield(get_tree().create_timer(0.1), "timeout")
		Music.playing = true
	
	yield(refresh(), "completed")
	if not usernames.has(id):
		yield(GotmScore.create("usernames", 0, {"id": str(id), "username": data["username"]}), "completed")
	done = true
	
func _process(delta):
	if done:
		refresh()
	if data != savedData:
		savedData = data.duplicate(true)
		SaveLoad.saveData("thebois34-ghost-mansion.data", data)

func getId(digits) -> String:
	var id = ""
	for i in range(digits):
		randomize()
		id += str(aToZ[floor(rand_range(0, len(aToZ)-1))])
	return id

func getLeaderboard(name2, maxRounds=3):
	var totalScores = []
	var leaderboard = GotmLeaderboard.new()
	leaderboard.name = name2
	var scores = yield(leaderboard.get_scores(), "completed")
	var i = 0
	totalScores.append_array(scores)
	var rounds = 0
	while len(scores) >= 20 and rounds < maxRounds:
		rounds += 1
		i += 1
		scores = yield(leaderboard.get_surrounding_scores(scores[19]), "completed")["after"]
		totalScores.append_array(scores)
	totalScores.invert()
	return totalScores
