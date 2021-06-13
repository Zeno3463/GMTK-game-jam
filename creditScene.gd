extends Control


func _process(delta):
	yield($AnimationPlayer, "animation_finished")
	queue_free()
