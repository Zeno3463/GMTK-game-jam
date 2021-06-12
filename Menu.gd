extends Control

func _on_Button_mouse_entered():
	$Button/AnimationPlayer.play("New Anim")
	

func _on_Button_button_down():
	var animPlayer = get_parent().get_node("ColorRect/AnimationPlayer")
	animPlayer.play_backwards("New Anim")
	yield(animPlayer, "animation_finished")
	get_tree().change_scene("res://1.tscn")

func _on_Button_mouse_exited():
	$Button/AnimationPlayer.play_backwards("New Anim")