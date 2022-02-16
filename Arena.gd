extends Spatial

signal point_gain


var max_bacteria = 100
var max_bacteria_distance = 50
var bacteria_spawn_distance = 15
var start_bacteria = 30

onready var timer = $Timer
onready var player = $Player

onready var enemies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()
	
	for i in range(start_bacteria):
		_on_Timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var copy = enemies
	for enemy in enemies:
		var detect = enemy.get_colliding_bodies()
		for node in detect:
			if node.get_name() == player.name:
				copy.erase(enemy)
				enemy.queue_free()
				emit_signal("point_gain")
		# Remove bacteria that are too far away.
		if player.translation.distance_to(enemy.global_transform.origin) > max_bacteria_distance:
			copy.erase(enemy)
			enemy.queue_free()
	enemies = copy

func _on_Timer_timeout():
	if len(enemies) > max_bacteria:
		return

	var bacteria = preload("res://Entities/Bacteria/Bacteria.tscn")
	var child = bacteria.instance()
	
	child.set_translation(player.translation+Vector3(
		rand_range(-bacteria_spawn_distance, bacteria_spawn_distance),
		rand_range(-bacteria_spawn_distance, bacteria_spawn_distance),
		rand_range(-bacteria_spawn_distance, bacteria_spawn_distance)))
	add_child(child)
	enemies.append(child)


func _on_Score_level_up():
	max_bacteria *= 0.9
	for i in range(start_bacteria):
		_on_Timer_timeout()
	Engine.time_scale += 0.1
