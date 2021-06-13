extends Node2D

var bullet = preload("res://bullet.tscn")
var lookVec = Vector2.ZERO
var speed = 500
var canShoot = true

var gunSprite = preload("res://Sprites/Weapon/New_Piskel-8.png.png")
var torchSprite = preload("res://Sprites/New_Piskel-47.png.png")

func _process(delta):
	#rotate towards mouse
	lookVec = get_global_mouse_position() - global_position
	global_rotation = atan2(lookVec.y, lookVec.x)
	if global_rotation < -1.5:
		scale.y = -1
	else:
		scale.y = 1

func _physics_process(delta):
	#shooting
	if canShoot:
		$gfx.texture = gunSprite
		$gfx.scale = Vector2.ONE * 2
		if Input.is_action_just_pressed("shoot"):
			#screen shake
			get_parent().get_parent().get_node("Camera2D").start()

			var shootSound = preload("res://sfx/player shoot.ogg")
			var audioPlayer = get_tree().get_root().get_node("/root/Sfx").get_node("AudioStreamPlayer")
			audioPlayer.stream = shootSound
			audioPlayer.play()

			var Bullet = bullet.instance()
			Bullet.get_node("bullet").vel = Vector2(cos(global_rotation), sin(global_rotation)) * speed
			Bullet.position = $Position2D.global_position
			get_parent().get_parent().add_child(Bullet)
			yield(get_tree().create_timer(1), "timeout")
			get_parent().get_parent().remove_child(Bullet)
	else:
		$gfx.texture = torchSprite
		$gfx.scale = Vector2.ONE * 2.5
		
