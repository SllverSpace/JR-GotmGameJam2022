extends TileMap

export (NodePath) var lightsPath
export (PackedScene) var light

tool

var timer = 0
var oldLights = 0

func _process(delta):
	
	if len(get_used_cells_by_id(4)) != oldLights:
		oldLights = len(get_used_cells_by_id(4))
		var lights = get_node(lightsPath)
		for light in lights.get_children():
			light.queue_free()
		for tilePos in get_used_cells_by_id(4):
			var lightNode = light.instance()
			lightNode.position = tilePos * 16 + Vector2(8, 8)
			lights.add_child(lightNode)
