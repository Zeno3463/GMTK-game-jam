extends CanvasLayer

onready var enemyCount = get_parent().get_node("Enemies").get_child_count()
var enemyKilled = 0

func _process(delta):
	$Label.text = "enemies killed: " + str(enemyKilled) + "/" + str(enemyCount)
