extends CanvasLayer

onready var enemyCount = get_parent().get_node("Enemies").get_child_count()
var enemyKilled = 0

func _ready():
	get_tree().get_root().get_node("/root/Bgm").resume()

func _process(delta):
	$Label.text = "enemies killed: " + str(enemyKilled) + "/" + str(enemyCount)
	if enemyKilled == enemyCount:
		
		get_tree().get_root().get_node("/root/Bgm").pause()
		
		var level = get_tree().current_scene.filename
		level.replace("res://", "").replace(".tscn", "")
		level = str(int(level) + 1)
		get_node("ColorRect/AnimationPlayer").play_backwards("New Anim")
		yield(get_node("ColorRect/AnimationPlayer"), "animation_finished")
		get_tree().change_scene("res://"+level+".tscn")
