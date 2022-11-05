extends Node2D

var timer = 0

func _ready():
	UI.get_node("Time").visible = true
	UI.timer = 0
	$"Editor Light".visible = false
	$Lights.visible = true

func _process(delta):
	timer += delta
	if timer >= 0.01:
		timer = 0
		var rain = load("res://Rain.tscn").instance()
		add_child(rain)
		rain.position.y = -320
		rain.position.x = rand_range(0, 1200)
	for lightNode in $Lights.get_children():
		if rand_range(0, 10) < 0.25:
			lightNode.energy = 4 - $player.position.distance_to(lightNode.position)/25
		else:
			lightNode.energy = 4 - $player.position.distance_to(lightNode.position)/30
		lightNode.visible = $player.position.distance_to(lightNode.position) < 100


func _on_Area2D2_body_entered(body):
	if body.name == "player":
		UI.stopTimer()
