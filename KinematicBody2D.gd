extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		vel.x = -1
	elif Input.is_action_pressed("right"):
		vel.x = 1
	else: vel.x = 0
	
	if Input.is_action_pressed("up"):
		vel.y = -1
	elif Input.is_action_pressed("down"):
		vel.y = 1
	else: vel.y = 0
	
	move_and_slide(vel.normalized() * speed)
