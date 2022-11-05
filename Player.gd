extends KinematicBody2D

export (float) var speed = 500
export (float) var gravity = 10
export (float) var jumpSpeed = 1000

var velocity = Vector2.ZERO

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("jump"):
			velocity.y = -jumpSpeed
	if is_on_ceiling():
		velocity.y = gravity
	
	velocity.y += gravity * delta
	velocity.x *= 0.5
	
	move_and_slide(velocity, Vector2.UP)
