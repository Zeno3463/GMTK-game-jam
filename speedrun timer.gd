extends Label

var time = 0
var start = false

func _process(delta):
	if get_tree().current_scene.filename == "res://1.tscn":
		start = true
	if get_tree().current_scene.filename == "res://6.tscn":
		start = false
		
	if start:
		time += stepify(delta, 0.01)
		text = str(time)
	
