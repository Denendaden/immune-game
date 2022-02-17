extends Label


signal level_up


var score = 0

# Points needed to level up
var level_up_points = [3, 7, 12, 18, 25, 35, 50, 75, 100, 150, 200, 250, 300]

func find_val(input, arr):
	for val in arr:
		if val > input:
			return val

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Arena_point_gain():
	score += 1
	
	var next_score = find_val(score, level_up_points)
	
	# Refresh the score counter
	text = str("Score: ", score) # , "\nTo Next Level: ", next_score-score
	
	# Check for a level up
	if score in level_up_points:
		level_up()


func level_up():
	emit_signal("level_up")
