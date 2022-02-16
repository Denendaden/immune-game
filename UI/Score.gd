extends Label


var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Arena_point_gain():
	score += 1
	
	# Refresh the score counter
	text = str("Score: ", score)
