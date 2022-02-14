extends RigidBody


var turn_force = 2   # Magnitude of force used to turn
var move_force = 24  # Magnitude of force used to move forward
var max_speed = 36   # Maximum speed allowed (past this no force will be applied to accelerate)

var half_length = 1  # Half the length of the macrophage (used to find the tip to apply torque)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	# Get global vectors for the direction the macrophage is facing.
	var dir_x = global_transform.basis.x
	var dir_y = global_transform.basis.y
	var dir_z = global_transform.basis.z
	
	# Apply forces to the tip of the macrophage to turn based on user input.
	if Input.is_action_pressed("move_up"):
		add_force(-dir_z * half_length, dir_y * turn_force)
	if Input.is_action_pressed("move_down"):
		add_force(-dir_z * half_length, -dir_y * turn_force)
	if Input.is_action_pressed("move_right"):
		add_force(-dir_z * half_length, -dir_x * turn_force)
	if Input.is_action_pressed("move_left"):
		add_force(-dir_z * half_length, dir_x * turn_force)
	
	# Move the macrophage forwards only if it is moving slow enough
	if get_linear_velocity().length() < max_speed:
		add_central_force(-dir_z * move_force)
