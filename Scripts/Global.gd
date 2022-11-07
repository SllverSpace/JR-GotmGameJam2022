extends Node

var aToZ = "abcdefghijklmnopqrstuvwxyzABCDEFFGHIJKLMNOPQRSTUVWXYZ"
var id = ""
var data = {}
var savedData = {}
var leaderboard = {}
var defaultData = {
	"username": "Unnamed", "muted": false, "id": getId(10)
}

func _ready():
	var config = GotmConfig.new()
	config.project_key = "authenticators/GAg8PUqTDFZzLlagDuRB"
	config.beta_unsafe_force_global_scores = true
	config.beta_unsafe_force_global_contents = true
	config.beta_unsafe_force_global_marks = true
	#Gotm.initialize(config)
	
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
