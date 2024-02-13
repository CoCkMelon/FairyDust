extends Node3D

var mob_scene : PackedScene = preload("res://scenes/movable/enemies/scary_nightmare.tscn")
var spawn_interval : float = 3.0  # Time between bursts
var burst_size : int = 5  # Number of enemies in each burst
var spawn_radius : float = 10.0  # Distance from player to spawn enemies

@onready var player =  $"../../Player stuff/Cube Character" # Assuming you have a player script named "Player"

var timer : Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

func _on_timer_timeout():
	if player:
		# Check if the player is within the spawn radius
		var distance_to_player = position.distance_to(player.global_transform.origin)
		
		if distance_to_player < spawn_radius:
			spawn_burst()

	# Restart the timer
	timer.start()

func spawn_burst():
	for r in range(burst_size):
		var mob = mob_scene.instantiate()
		mob.position = Vector3(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius), 0)
		add_sibling(mob)
