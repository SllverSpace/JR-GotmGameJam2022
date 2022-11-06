extends Area2D

var velocity = 0
var timer = 0
export (float) var gravity2 = 3

func _ready():
	var scale2 = rand_range(0.1, 2)
	scale.x = scale2
	scale.y = scale2

func _process(delta):
	velocity += gravity2
	
	position.y += velocity * delta
	
	timer += delta
	if timer >= 10:
		queue_free()
		
func _on_Rain_body_entered(body):
	if not "Rain" in body.name:
		queue_free()
