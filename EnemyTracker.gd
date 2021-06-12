extends CanvasLayer

onready var enemyCount = get_parent().get_node("Enemies").get_child_count()
var enemyKilled = 0

func _process(delta):
	$Label.text = "enemies killed: " + str(enemyKilled) + "/" + str(enemyCount)
	if enemyKilled == enemyCount:
		var level = get_tree().current_scene.filename
		level.replace("res://", "").replace(".tscn", "")
		level = str(int(level) + 1)
		get_tree().change_scene("res://"+level+".tscn")
