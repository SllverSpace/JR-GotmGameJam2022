extends Node2D

var timer = 0
#var flash = rand_range(5, 15)
#var flash2 = rand_range(0.3,1.8)
#var flash2_maybe = rand_range(1,2)
var flashCooldown = rand_range(5, 15)
var flashTimer = flashCooldown
var flashTimer2 = flashCooldown+0.2

func _ready():
	flashCooldown = rand_range(5, 15)
	$FLASH.visible = false
	$Area2D2/Light.visible = true
	$Tiles.modulate = Color(0.15, 0.15, 0.15)
	UI.get_node("Time").visible = true
	UI.timer = 0
	UI.startTimer()
	$Lights.visible = true
	$Tiles/world_troll_blocking.visible = false
	$Label4.visible = false


func _process(delta):
#	$Area2D2/Ghost.look_at(get_node("player").position)
#	$Area2D2/Ghost2.look_at(get_node("player").position)
#	$Area2D2/Ghost3.look_at(get_node("player").position)
#	$Area2D2/Ghost4.look_at(get_node("player").position)
#	$Area2D2/Ghost5.look_at(get_node("player").position)
#	$Ghost.look_at(get_node("player").position)
	
	timer += delta
	if timer > 0.03:
		timer = 0
		var rain = load("res://Rain.tscn").instance()
		add_child(rain)
		rain.position.y = rand_range(-320, -250)
		rain.position.x = rand_range($player.position.x-350, $player.position.x+350)
		
	for lightNode in $Lights.get_children():
		if rand_range(0, 10) < 0.25:
			lightNode.modulate.a = 0.75-$player.position.distance_to(lightNode.position)/50
		else:
			lightNode.modulate.a = 1-$player.position.distance_to(lightNode.position)/50
		lightNode.visible = $player.position.distance_to(lightNode.position) < 50
	
	flashTimer -= delta
	flashTimer2 -= delta
	if flashTimer <= 0:
		if flashTimer > -0.1:
			$FLASH.visible = true
		else:
			$FLASH.visible = false
			flashTimer = flashCooldown
	if flashTimer2 <= 0:
		if flashTimer2 > -0.1:
			$FLASH.visible = true
		else:
			$FLASH.visible = false
			flashTimer2 = flashCooldown+0.2
			flashCooldown = rand_range(5, 15)
	
	
#	yield(get_tree().create_timer(flash), "timeout")
#	$FLASH.visible = true
#	yield(get_tree().create_timer(0.2), "timeout")
#	$FLASH.visible = false

func _on_Area2D2_body_entered(body):
	if body.name == "player":
		UI.stopTimer()
		$player/Camera2D.smoothing_speed = 0.1
		$player/Camera2D.position.y = -10000
		Transition.setMsg("green", "You Finished!\n" + str(round(UI.timer*100)/100))
		Transition.switchScene("res://Scenes/Menu.tscn")

func _on_Area2D3_body_entered(body):
	if body.name == "player": 
		$Tiles/world_troll_blocking.visible = true

func _on_Area2D4_body_entered(body):
	if body.name == "player":
		$Label4.visible = true


func _on_Area2D5_body_entered(body):
	if body.name == "player":
		$Label2.text = str("hello >:)")
