extends Control

onready var healthCount = get_child_count()

func damage():
	healthCount -= 1
	if healthCount == 0:
		get_parent().get_parent().get_node("Player").die()
		get_child(0).queue_free()
	elif healthCount > 0:
		get_child(get_child_count() - 1).queue_free()
