extends Camera2D

onready var player = get_parent().get_node("Player")
var can_follow_player = true

func _process(delta):
	if can_follow_player:
		global_position = player.global_position
	
	if Input.is_action_just_pressed("click"):
		can_follow_player = not can_follow_player
