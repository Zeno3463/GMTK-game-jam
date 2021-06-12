extends KinematicBody2D

export var dir = Vector2.LEFT
export var randomizedMovement = true
export var speed = 100
var inRange = false
var particle = preload("res://explosion.tscn")

func _ready():
	randomize()

func _process(delta):
	if not inRange:
		get_node("Sprite").visible = false
	else: 
		get_node("Sprite").visible = true

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
	if body.name == "Player" and inRange and body.canTakeDamage:
		get_parent().get_parent().get_node("Player").damage()
		get_parent().get_parent().get_node("CanvasLayer/Control").damage()
		
func die():
	var Particle = particle.instance()
	Particle.emitting = true
	Particle.rotation_degrees = 0
	Particle.global_position = global_position
	get_tree().get_root().get_node(".").add_child(Particle)
	get_parent().get_parent().get_node("CanvasLayer").enemyKilled += 1
	queue_free()
