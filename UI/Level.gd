extends Label


var level = 1

onready var display_timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	show_level()


func show_level():
	show()
	display_timer.start()


func _on_Score_level_up():
	level += 1
	text = str("Level ", level)
	
	show_level()


func _on_Timer_timeout():
	# Hide the level up display.
	hide()
