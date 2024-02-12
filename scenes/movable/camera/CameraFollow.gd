extends Camera3D


@export var target_distance = 5
@export var target_height = 2
@export var speed:=20.0
var follow_this = null
var last_lookat

# Spring arm parameters
var arm_length : float = 5.0
var springiness : float = 0.2

func _ready():
	#follow_this = get_parent()
	follow_this = $"../Cube Character"
	last_lookat = follow_this.global_transform.origin

func _physics_process(delta):
	var delta_v = follow_this.global_transform.origin - global_transform.origin
	var target_pos = global_transform.origin
	var current_pos = global_transform.origin
	
	# Ignore changes in the Y-axis
	delta_v.y = 0.0
	
	if (delta_v.length() > target_distance):
		delta_v = delta_v.normalized() * target_distance
		delta_v.y = target_height
		target_pos = follow_this.global_transform.origin - delta_v
	else:
		target_pos.y = follow_this.global_transform.origin.y + target_height
	
	# Linear interpolation to smoothly move towards the target position
	global_transform.origin = global_transform.origin.lerp(target_pos, delta * speed)
	
	# Lerp for the look-at position
	last_lookat = last_lookat.lerp(follow_this.global_transform.origin, delta * speed)
	look_at(last_lookat, Vector3.UP)

	# Calculate the desired position for the spring arm effect
	var gopos = Vector3(target_pos.x, target_pos.y, current_pos.z)
	
	# Apply springiness to smoothly move towards the desired position
	current_pos.x = current_pos.x + (gopos.x - current_pos.x) * springiness
	current_pos.y = current_pos.y + (gopos.y - current_pos.y) * springiness
	
	# Set the new position while keeping the z-axis unchanged
	global_transform.origin = Vector3(current_pos.x, current_pos.y, current_pos.z)
