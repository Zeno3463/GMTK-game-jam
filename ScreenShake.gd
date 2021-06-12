extends Camera2D

var amplitude = 500
var done = true

func _process(delta):
	if not done:
		shake()
	else:
		$Tween.stop_all()
		reset()
	
func start():
	done = false
	$Timer.start()
	
func shake():
	var rand = Vector2.ZERO
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$Tween.interpolate_property(self, 
	"offset", 
	self.offset, 
	rand, 
	0.5, 
	Tween.TRANS_SINE, 
	Tween.EASE_IN_OUT)
	$Tween.start()

func reset():
	$Tween.interpolate_property(self, 
	"offset", 
	self.offset, 
	Vector2.ZERO, 
	0.1, 
	Tween.TRANS_SINE, 
	Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.stop_all()


func _on_Timer_timeout():
	done = true
