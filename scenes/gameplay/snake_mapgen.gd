extends Node3D

# Platform scenes to spawn
var platform_scene : PackedScene = preload("res://assets/Environments/Forest/wooden_log_marshmallow_caramel_model_obj/wood_log.tscn")

# Number of platforms to spawn
var num_platforms : int = 50

# Range for the length of each platform
var min_length : float = 2.0
var max_length : float = 3.0

# Range for the distance between platforms
var min_distance : float = 1.0
var max_distance : float = 3.0

func _ready():
	spawn_platforms()

func spawn_platforms():
	var current_position : Vector3 = global_position

	for i in range(num_platforms):
		# Spawn the platform
		var platform = platform_scene.instantiate()
		add_child(platform)

		# Randomly choose a direction
		var direction = Vector2(randf(), randf()).normalized()

		# Randomly select length
		var length = randf_range(min_length, max_length)

		# Calculate the next position
		var next_position = current_position + Vector3((direction.x-0.5) * 2 * length, (direction.y-0.5)* 2 * length, 0.0)

		# Spawn the platform at the calculated position
		platform.global_position = current_position.lerp(next_position, 0.5)
		
		# Spawn some random platforms along the way
		spawn_random_platforms(current_position, next_position)

		# Update current position for the next iteration
		current_position = next_position # + Vector3(randf_range(min_distance, max_distance), randf_range(min_distance, max_distance), 0.0)

func spawn_random_platforms(start_pos, end_pos):
	var num_random_platforms = 1 #randi() % 3  # Adjust the number of random platforms as needed

	for i in range(num_random_platforms):
		# Spawn random platforms along the way
		var random_platform = platform_scene.instantiate()
		add_child(random_platform)

		# Calculate a random position along the way
		var random_pos = start_pos.lerp(end_pos, 5*randf_range(0.25,0.75))

		# Set the platform's position
		random_platform.global_position = random_pos
