extends Node

var aToZ = "abcdefghijklmnopqrstuvwxyzABCDEFFGHIJKLMNOPQRSTUVWXYZ"
var id = ""
var data = {}
var savedData = {}

func _ready():
	var data2 = SaveLoad.loadData("thebois34-ghost-mansion.data")
	if data2.has("id"):
		id = data2["id"]
		data = data2.duplicate(true)
	else:
		id = Global.getId(10)
		data = {"id": id, "Username": "Unnamed", "Muted": false}
		SaveLoad.saveData("thebois34-ghost-mansion.data", {"id": id, "Username": "Unnamed", "Muted": false})
	savedData = data.duplicate(true)
	
	if not data["Muted"]:
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
