extends CharacterBody3D

var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var move_speed : float = 3.0
# Jump strength
var jump_strength : float = 1.0
# Distance at which the mob starts jumping towards the player
var jump_trigger_distance : float = 2.0
# Flag to prevent continuous jumping
var can_jump : bool = true

var damaged_timer = 0
var damaged_indication_time = 0.1

@onready var player_target = $"../../Player stuff/Cube Character"
@onready var collisider = $"Monster Collision sphere"
@onready var mesh = $Dark_face_smoke_horror
@onready var material = mesh.get_active_material(0)
var newMaterial

func _ready():
	newMaterial = material.duplicate() #Make a new Spatial Material
	#newMaterial.albedo_color = Color(0.92, 0.69, 0.13, 1.0) #Set color of new material
	mesh.material_override = newMaterial #Assign new material to material overrride

func _process(delta):
	if damaged_timer > 0:
		newMaterial.albedo_color = Color(10,0,0)
		damaged_timer-=delta
	else:
		newMaterial.albedo_color = Color(1,1,1)

func _physics_process(delta):
	# Check if a player target is set
	if player_target:
		# Calculate the direction towards the player
		var target_direction = (player_target.position - position).normalized()
		#look_at(player_target.global_position)
		#look_at(global_position + player_target.global_position, Vector3.UP)
		rotate_towards(target_direction)
		var distance_to_player = position.distance_to(player_target.position)
		# Move the mob towards the player
		if can_jump:
			velocity = target_direction * move_speed
		else:
			velocity = target_direction * (move_speed+jump_strength*pow(3,distance_to_player))
		# Check the distance to the player

		# Check if the mob is close enough to the player to trigger a jump
		if distance_to_player < jump_trigger_distance and can_jump:
			jump(target_direction)
		move_and_slide()
		handle_collision()
	else:
		push_warning("Player target not set.")

func jump(target_direction):
	# Apply a vertical impulse to simulate a jump
	#velocity += target_direction * jump_strength 
	can_jump = false  # Prevent continuous jumping
	await get_tree().create_timer(1.0).timeout
	can_jump = true  # Allow jumping after a cooldown

func handle_collision():
	var collision = get_last_slide_collision()
	if !collision:
		return
	var body = collision.get_collider()
	# Check if the collided object belongs to a specific group
	if body.is_in_group("bullet"):
		# Code to execute when a bullet (in the "bullets" group) hits the mob
		take_damage(10.0)
		for child in body.get_children():
			child.queue_free()
		body.queue_free()

func rotate_towards(target_rotation: Vector3):
	rotation.z = -atan2(target_rotation.x, target_rotation.y)+PI/2

func take_damage(damage_amount: float):
	health -= damage_amount
	damaged_timer = damaged_indication_time

	# Check if the mob's health has reached zero or below
	if health <= 0:
		die()

# Method to handle the mob's death
func die():
	queue_free()  # Destroy the mob when it dies
