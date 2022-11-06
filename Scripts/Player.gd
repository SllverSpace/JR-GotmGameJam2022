extends KinematicBody2D

export (float) var speed = 500
export (float) var gravity = 10
export (float) var jumpSpeed = 1000

var ticks = 0
var jumps = 0
var velocity = Vector2.ZERO
var light_on = 0

func _physics_process(delta):
	ticks += 1
	$Sprite.position.y = sin(ticks)*2
	
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$Sprite.scale.x = 1
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$Sprite.scale.x = -1
	
	$Sprite/Light2D.look_at(get_global_mouse_position())
	if Input. is_action_just_pressed("use"):
		if light_on == 1:
			light_on = 0
		if light_on == 0:
			light_on = 1

	if light_on == 1:
		$Sprite/Light2D.enabled = true
		
	if light_on == 0:
		$Sprite/Light2D.enabled = false
	
	
	if is_on_floor():
		jumps = 2
		velocity.y = 0
	
	if Input.is_action_just_pressed("jump") and jumps > 0:
		jumps -= 1
		velocity.y = -jumpSpeed
	if is_on_ceiling():
		velocity.y = gravity
	
	velocity.y += gravity * delta * 60
	velocity.x *= 0.5
	
	var oldPos = position
	move_and_slide(velocity, Vector2.UP)
	var move = (position-oldPos)*60

func _on_Area2D_body_entered(body):
	while $Camera2D.zoom != Vector2(0, 0):
		$Camera2D.zoom -= Vector2(0.1, 0.1)

