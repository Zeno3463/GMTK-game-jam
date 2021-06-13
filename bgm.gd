extends AudioStreamPlayer

onready var time = get_playback_position()

func _process(delta):
	time = get_playback_position()

func resume():
	play()
	seek(time)
	
func pause():
	stop()
