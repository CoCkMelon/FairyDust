extends Node3D

# stone scene to spawn
var stone_scene : PackedScene = preload("res://scenes/movable/throwstone.tscn")

# Shooting parameters
var shoot_speed : float = 10.0
var shoot_interval : float = 3.0  # Minimum time between shots
var stone_lifetime : float = 50.0
var can_shoot = true
var time_since_last_shot : float = 0.0
var game_time : float = 0.0

# Array to store active stones
var stones : Array = []

func _ready():
	pass

func _process(delta):
	game_time += delta
	time_since_last_shot += delta
	update_stones(delta)  # Adding this for tracking individual stone lifetimes
	# Check for input to shoot
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	# Get the player's camera
	var camera = get_node("../../Player Camera")  # Adjust the path based on your scene structure

	# Calculate the mouse position in the viewport
	var mouse_pos = get_viewport().get_mouse_position()

	# Create a ray from the camera to the mouse position
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000.0  # Adjust the length as needed

	# Calculate the intersection point with the z = 0 plane
	var shoot_plane_point = Plane(Vector3(0, 0, 1), Vector3(0, 0, 0)).intersects_ray(from, to)

	if shoot_plane_point != Vector3():

		# Calculate the direction towards the shoot plane point
		var shoot_direction = (shoot_plane_point - global_transform.origin).normalized()
		
		rotate_towards(shoot_direction)
		if time_since_last_shot <= shoot_interval:
			return
		# Spawn a stone
		var stone = stone_scene.instantiate()
		$"../..".add_child(stone)
		stone.add_to_group("stone", true)

		# Set the stone's initial position and direction
		stone.global_transform.origin = global_transform.origin + shoot_direction
		stone.global_transform.basis.z = -global_transform.basis.z  # Shoot in the opposite direction of the player

		# Apply velocity to the stone
		stone.apply_impulse(shoot_direction * shoot_speed, Vector3.ZERO)

		# Record the stone and its creation time
		stones.append({"stone": stone, "creation_time": game_time})

		# Disable shooting temporarily to prevent rapid firing
		can_shoot = false
		time_since_last_shot = 0.0  # Reset the time since the last shot
	else:
		# If the ray does not intersect with the shoot plane, reset the shooting cooldown
		time_since_last_shot = shoot_interval

func update_stones(delta):
	var stones_to_remove : Array = []
	for i in range(stones.size() - 1, -1, -1):
		var stone_entry = stones[i]

		# Compare the time difference to stone lifetime
		if game_time - stone_entry["creation_time"] > stone_lifetime:
			var stone = stone_entry["stone"]
			if !stone:
				continue

			# Manually free all of the stone's children
			for child in stone.get_children():
				child.queue_free()
			stone.queue_free()

			# Add the index to the list for removal
			stones_to_remove.append(i)

	# Remove stones outside the loop to avoid modifying array while iterating
	for index in stones_to_remove:
		stones.remove_at(index)

func rotate_towards(target_rotation: Vector3):
	rotation.z = min(2*PI, -atan2(target_rotation.x, target_rotation.y)+PI/2)
	if rotation.z < PI/2:
		scale.y = 1
	else:
		scale.y = -1
