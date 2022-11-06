extends Node2D

var timer = 0

func _ready():
	$Area2D2/Light.visible = true
	$Tiles.modulate = Color(0.102, 0.102, 0.102)
	UI.get_node("Time").visible = true
	UI.timer = 0
	UI.startTimer()
	$Lights.visible = true

func _process(delta):
	$Tiles/world_troll_blocking.visible = false
	for i in range(1):
		var rain = load("res://Rain.tscn").instance()
		add_child(rain)
		rain.position.y = rand_range(-320, -250)
		rain.position.x = rand_range(0, 1200)
		
	for lightNode in $Lights.get_children():
		if rand_range(0, 10) < 0.25:
			lightNode.energy = 10 - $player.position.distance_to(lightNode.position)/5
		else:
			lightNode.energy = 10 - $player.position.distance_to(lightNode.position)/5
		lightNode.visible = $player.position.distance_to(lightNode.position) < 50
		lightNode.enabled = $player.position.distance_to(lightNode.position) < 50

func _on_Area2D2_body_entered(body):
	if body.name == "player":
		UI.stopTimer()
		$player/Camera2D.smoothing_speed = 0.1
		$player/Camera2D.position.y = -10000
		Transition.setMsg("green", "You Finished!\n" + str(round(UI.timer*100)/100))
		Transition.switchScene("res://Scenes/Menu.tscn")

