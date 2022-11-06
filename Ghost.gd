extends KinematicBody2D

export (float) var speed = 50
export (NodePath) var playerPath
onready var player = get_node(playerPath)
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity += (player.position-position)/2/6
	velocity *= 0.9
	move_and_slide(velocity)


