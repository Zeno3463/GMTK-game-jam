extends Node2D

var bullet = preload("res://bullet.tscn")
var lookVec = Vector2.ZERO
var speed = 500

func _process(delta):
	#rotate towards mouse
	lookVec = get_global_mouse_position() - global_position
	global_rotation = atan2(lookVec.y, lookVec.x)

func _physics_process(delta):
	#shooting
	if Input.is_action_just_pressed("shoot"):
#		#screen shake
#		get_parent().get_node("Camera2D").start()

		var Bullet = bullet.instance()
		Bullet.get_node("bullet").vel = Vector2(cos(global_rotation), sin(global_rotation)) * speed
		Bullet.position = $Position2D.global_position
		get_parent().get_parent().add_child(Bullet)
		yield(get_tree().create_timer(1), "timeout")
		get_parent().get_parent().remove_child(Bullet)
		
