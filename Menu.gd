extends Control

func _on_Button_button_down():
	$Button.modulate = Color8(137, 137, 137)
	var startSound = preload("res://sfx/start.ogg")
	var audioPlayer = get_tree().get_root().get_node("/root/GameSfx").get_node("AudioStreamPlayer")
	audioPlayer.stream = startSound
	audioPlayer.play()
	
	var animPlayer = get_parent().get_node("ColorRect/AnimationPlayer")
	animPlayer.play_backwards("New Anim")
	yield(animPlayer, "animation_finished")
	get_tree().change_scene("res://1.tscn")
