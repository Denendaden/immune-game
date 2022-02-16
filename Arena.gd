extends Spatial

onready var timer = $Timer
onready var player = $Player

onready var enemies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var copy = enemies
	for enemy in enemies:
		var detect = enemy.get_colliding_bodies()
		for node in detect:
			if node.get_name() == player.name:
				copy.erase(enemy)
				enemy.queue_free()
	enemies = copy

func _on_Timer_timeout():
	var bacteria = preload("res://Entities/Bacteria/Bacteria.tscn")
	var child = bacteria.instance()
	
	child.set_translation(player.translation+Vector3(rand_range(-3, 3), rand_range(-3, 3), rand_range(-3, 3)))
	add_child(child)
	enemies.append(child)
