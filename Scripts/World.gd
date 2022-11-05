extends TileMap

export (NodePath) var lightsPath
export (PackedScene) var light
export (bool) var reloadLights = false

tool

func _ready():
	var lights = get_node(lightsPath)
	for light in lights.get_children():
		light.queue_free()
	yield(get_tree().create_timer(0.1), "timeout")
	for tilePos in get_used_cells_by_id(4):
		var lightNode = light.instance()
		lightNode.position = tilePos * 16 + Vector2(8, 8)
		lights.add_child(lightNode)

func _process(delta):
	if reloadLights:
		reloadLights = false
		var lights = get_node(lightsPath)
		for light in lights.get_children():
			light.queue_free()
		for tilePos in get_used_cells_by_id(4):
			var lightNode = light.instance()
			lightNode.position = tilePos * 16 + Vector2(8, 8)
			lights.add_child(lightNode)
