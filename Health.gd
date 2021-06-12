extends Control

onready var healthCount = get_child_count()

func damage():
	healthCount -= 1
	get_child(get_child_count() - 1).queue_free()
