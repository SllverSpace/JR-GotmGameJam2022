extends KinematicBody2D

var velocity = 0
var timer = 0
export (float) var gravity = 5

func _process(delta):
	velocity += gravity
	
	move_and_slide(Vector2(0, velocity))
	
	timer += delta
	if timer >= 10:
		queue_free()
	
	for collisionI in range(get_slide_count()):
		var body = get_slide_collision(collisionI).collider
		if not "Rain" in body.name:
			queue_free()
