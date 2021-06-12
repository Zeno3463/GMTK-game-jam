extends KinematicBody2D

export var dir = Vector2.LEFT
export var randomizedMovement = true
export var speed = 100
var inRange = false

func _ready():
	randomize()

func _process(delta):
	if not inRange:
		get_node("Sprite").visible = false
		get_node("LightOccluder2D").visible = false
	else: 
		get_node("Sprite").visible = true
		get_node("LightOccluder2D").visible = true

	if dir.x < 0:
		get_node("Sprite").flip_h = true
	elif dir.x > 0:
		get_node("Sprite").flip_h = false

func _physics_process(delta):
	
	# random movement
	move_and_slide(dir * speed)
	if is_on_wall():
		if not randomizedMovement:
			dir *= -1
		else:
			dir = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
func _on_Area2D_body_entered(body):
	# if the player touches the enemy
	if body.name == "KinematicBody2D" and inRange:
		body.die()
		
func die():
	queue_free()
