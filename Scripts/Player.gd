extends KinematicBody2D

export (float) var speed = 500
export (float) var gravity = 10
export (float) var jumpSpeed = 1000

var ticks = 0
var onFloor = false
var jumps = 0
var targetAngle = 0
var velocity = Vector2.ZERO

func _physics_process(delta):
	ticks += 1
	$Sprite.position.y = sin(ticks)*2
	
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$Sprite.scale.x = 1
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$Sprite.scale.x = -1
	
	$Light2D.look_at(get_global_mouse_position())
	if Input. is_action_just_pressed("use"):
		$Light2D.enabled = not $Light2D.enabled
	
	if onFloor:
		jumps = 2
		
	if is_on_floor():
		jumps = 2
		velocity.y = 0
	
	$Sprite/CPUParticles2D.emitting = jumps < 1 and velocity.y < 0
	if $Sprite/CPUParticles2D.emitting:
		targetAngle += 720 * delta * $Sprite.scale.x
	else:
		targetAngle = velocity.x/15
	
	if Input.is_action_just_pressed("jump") and jumps > 0:
		if jumps < 2:
			pass
		jumps -= 1
		velocity.y = -jumpSpeed
	if is_on_ceiling():
		velocity.y = gravity

	if Input.is_action_pressed("down") and not is_on_floor():
		$Sprite/CPUParticles2D.emitting = true
		targetAngle = 180
#		if velocity.y < 0:
#			velocity.y = gravity
		gravity *= 4
	velocity.y += gravity * delta * 60
	if Input.is_action_pressed("down") and not is_on_floor():
		gravity /= 4
	
	if jumps > 0:
		velocity.x *= 0.5
	else:
		velocity.x *= 0.55
	
	var oldPos = position
	move_and_slide(velocity, Vector2.UP)
	$Sprite.rotation = lerp_angle(deg2rad($Sprite.rotation_degrees), deg2rad(targetAngle), 0.1)
	var move = (position-oldPos)*60

func _on_Area2D_body_entered(body):
	if body.name == "Ghost":
		if body.position.y > position.y and velocity.y > gravity*2:
			jumps = 1
			if Input.is_action_pressed("down"):
				velocity.y = -jumpSpeed*2
				body.velocity.y = jumpSpeed*2
			else:
				velocity.y = -jumpSpeed
				body.velocity.y = jumpSpeed
			body.get_node("AnimationPlayer").play("shake")
		else:
			$Camera2D.smoothing_speed = 0.1
			$Camera2D.position.y = -10000
			Transition.setMsg("red", "YOU DIED")
			Transition.switchScene("res://Scenes/Menu.tscn")

func _on_Floor_body_entered(body):
	if body.name != name:
		onFloor = true

func _on_Floor_body_exited(body):
	if body.name != name:
		onFloor = false
