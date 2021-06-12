extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250
var vision = 0.5
var movingLeft = true

func _process(delta):
	if Input.is_action_just_pressed("click"):
		vision = 2 if vision == 0.5 else 0.5
		get_node("weapon").canShoot = not get_node("weapon").canShoot
	get_node("Sprite2").scale = Vector2(vision, vision)
	get_node("Light2D").scale = Vector2(vision, vision)
	get_node("Area2D").scale = Vector2(vision, vision)
		

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		vel.x = -1
	elif Input.is_action_pressed("right"):
		vel.x = 1
	else: vel.x = 0
	
	if vel.x >= 1:
		get_node("Sprite").flip_h = false
	elif vel.x <= -1:
		get_node("Sprite").flip_h = true
	
	if vel == Vector2.ZERO:
		get_node("Sprite").playing = false
	else:
		get_node("Sprite").playing = true
	
	if Input.is_action_pressed("up"):
		vel.y = -1
	elif Input.is_action_pressed("down"):
		vel.y = 1
	else: vel.y = 0
	
	move_and_slide(vel.normalized() * speed)

func _on_Area2D_body_entered(body):
	if body.name == "enemy":
		body.inRange = true

func _on_Area2D_body_exited(body):
	if body.name == "enemy":
		body.inRange = false
