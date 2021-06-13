extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250
var vision = 0.3
var movingLeft = true

var timeBtwSwitch = 0
var startTimeBtwSwitch = 1

var died = false
var canTakeDamage = true

func _process(delta):
	if not died:
		if Input.is_action_just_pressed("click") and timeBtwSwitch <= 0:
			
			var selectSound = preload("res://sfx/up down select.ogg")
			var audioPlayer = get_tree().get_root().get_node("/root/GameSfx").get_node("AudioStreamPlayer")
			audioPlayer.stream = selectSound
			audioPlayer.play()
			
			get_node("weapon").canShoot = not get_node("weapon").canShoot
			vision = 2 if vision == 0.3 else 0.3
			timeBtwSwitch = startTimeBtwSwitch
		else:
			timeBtwSwitch -= delta
		
	get_parent().get_node("CanvasLayer/TextureProgress").value = (startTimeBtwSwitch - timeBtwSwitch)/startTimeBtwSwitch * 100
	
	get_node("Sprite2").scale = Vector2(vision, vision)
	get_node("Light2D").scale = Vector2(vision, vision)
	get_node("Area2D").scale = Vector2(vision, vision)
		

func _physics_process(delta):
	if not died:
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
		
		if vel.x >= 1:
			get_node("Sprite").flip_h = false
		elif vel.x <= -1:
			get_node("Sprite").flip_h = true
		
		if vel == Vector2.ZERO:
			get_node("Sprite").playing = false
			get_node("Sprite").frame = 1
		else:
			get_node("Sprite").playing = true
		
		
		move_and_slide(vel.normalized() * speed)

func damage():
	canTakeDamage = false
	move_and_slide(-vel.normalized() * 2000)
	
	var hurtSound = preload("res://sfx/player get hit.ogg")
	var audioPlayer = get_tree().get_root().get_node("/root/GameSfx").get_node("AudioStreamPlayer")
	audioPlayer.stream = hurtSound
	audioPlayer.play()
	
	yield(get_tree().create_timer(1), "timeout")
	canTakeDamage = true

func die():
	died = true
	
	var deadSound = preload("res://sfx/player dead.ogg")
	var audioPlayer = get_tree().get_root().get_node("/root/GameSfx").get_node("AudioStreamPlayer")
	audioPlayer.stream = deadSound
	audioPlayer.play()
	
	$Sprite.play("death")
	yield($Sprite, "animation_finished")
	$Sprite.playing = false
	$Sprite.frame = 6
	var animPlayer = get_parent().get_node("CanvasLayer/ColorRect/AnimationPlayer")
	animPlayer.play_backwards("New Anim")
	
	
	yield(animPlayer, "animation_finished")
	get_tree().change_scene(get_tree().current_scene.filename)
	died = false

func _on_Area2D_body_entered(body):
	if body.name[0] == "e":
		body.inRange = true

func _on_Area2D_body_exited(body):
	if body.name[0] == "e":
		body.inRange = false
