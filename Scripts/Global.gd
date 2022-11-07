extends Node

var aToZ = "abcdefghijklmnopqrstuvwxyzABCDEFFGHIJKLMNOPQRSTUVWXYZ"
var id = ""
var data = {}
var savedData = {}
var leaderboard = []
var scores = {}
var usernames = {}
var defaultData = {
	"username": "Unnamed", "muted": false, "id": getId(10), "bestTime": 0
}

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
	
	var leaderboard2 = GotmLeaderboard.new()
	leaderboard2.name = "time"
	leaderboard2.is_inverted = true
	leaderboard = yield(leaderboard2.get_scores(), "completed")
	
	var usernames2 = yield(getLeaderboard("usernames"), "completed")
	var ids = []
	for score in usernames2:
		ids.append(score.properties["id"])
		scores[score.properties["id"]] = score
		usernames[score.properties["id"]] = score.properties["username"]
	if not id in ids:
		yield(GotmScore.create("usernames", 0, {"id": str(id), "username": data["username"]}), "completed")
	#leaderboard = yield(getLeaderboard("time"), "completed")
	
func _process(delta):
	if data != savedData:
		savedData = data.duplicate(true)
		SaveLoad.saveData("thebois34-ghost-mansion.data", data)

func getId(digits) -> String:
	var id = ""
	for i in range(digits):
		randomize()
		id += str(aToZ[floor(rand_range(0, len(aToZ)-1))])
	return id

func getLeaderboard(name2):
	var totalScores = []
	var leaderboard = GotmLeaderboard.new()
	leaderboard.name = name2
	var scores = yield(leaderboard.get_scores(), "completed")
	var i = 0
	totalScores.append_array(scores)
	while len(scores) >= 20:
		i += 1
		scores = yield(leaderboard.get_surrounding_scores(scores[19]), "completed")["after"]
		totalScores.append_array(scores)
	return totalScores
