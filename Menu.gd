extends Control

func _on_Button_button_down():
	$Button.modulate = Color8(137, 137, 137)
	var animPlayer = get_parent().get_node("ColorRect/AnimationPlayer")
	animPlayer.play_backwards("New Anim")
	yield(animPlayer, "animation_finished")
	get_tree().change_scene("res://1.tscn")
