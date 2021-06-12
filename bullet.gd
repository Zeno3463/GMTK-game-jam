extends KinematicBody2D

var vel = Vector2.ZERO

func _physics_process(delta):
	move_and_slide(vel)

func _on_Area2D_body_entered(body):
	if body != self and body.name != "Player":
		queue_free()
	if body.name[0] == "e":
		body.die()
