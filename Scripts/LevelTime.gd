extends Label

signal lose

onready var timer = $LevelTimer

func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()

func get_time(value):
	var rounded = int(round(value))
	return [floor(rounded/60), rounded-floor(rounded/60)*60]

func _on_Score_level_up():
	timer.stop()
	timer.start()

func _process(_delta):
	var times = get_time(timer.get_time_left())
	if times[1] < 10:
		times[1] = "0"+str(times[1])
	text = str("Timer: ", times[0], ":", times[1])

func _on_Timer_timeout():
	timer.stop()

func _on_LoseTimer_timeout():
	emit_signal("lose")
