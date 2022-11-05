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
		lightNode.visible = $player.position.distance_to(lightNode.position) < 75

		
		
