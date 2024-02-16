extends Node3D

@export var mob_scene : PackedScene = preload("res://scenes/movable/enemies/scary_nightmare.tscn")

@export var spawn_interval : float = 3.0 # Time between bursts
@export var burst_size : int = 5  # Number of enemies in each burst
@export var spawn_radius : float = 10.0  # Distance from player to spawn enemies
@export var min_spawn_radius: float = 3
@export var number_of_mobs: int = 400
var spawned_cnt = 0
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
	if(spawned_cnt >=number_of_mobs):
		return
	for r in range(burst_size):
		spawned_cnt+=1
		var mob = mob_scene.instantiate()
		while true:
			mob.position = Vector3(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius), 0)
			if mob.position.distance_to(player.position) > min_spawn_radius:
				break
		
		add_sibling(mob)
