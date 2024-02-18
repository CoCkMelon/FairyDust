extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10.0
const dash_speed = 10.0
var dashtimer = 0
var dash_cd_part = 0.75
var dash_time = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var model = $"fairy with animations"

var downlerp = 0
const sidespeed = 10
const sidedistance = 2

@onready var initial_model_rotation = model.rotation

func _ready():
	PlayerStats.reset_health()
	PlayerStats.current_player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle dash.
	if dashtimer == 0:
		if Input.is_action_just_pressed("dash"):
			dashtimer = dash_time
	else:
		dashtimer-=delta
		dashtimer = max(dashtimer, 0)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y -= direction.y * SPEED / 10.
		velocity.y = velocity.y-((velocity.y/20)*(velocity.y/20)*(velocity.y/20))
		if(dashtimer/dash_time > dash_cd_part):
			velocity.x += direction.x * dash_speed
			velocity.y -= direction.y * dash_speed / 2.
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if (is_on_floor() or is_on_wall() or is_on_ceiling() or downlerp > 0) and Input.is_action_pressed("jump"):
			downlerp += delta * sidespeed
			downlerp = min(downlerp, sidedistance)
			
			position = Vector3(position.x, position.y, downlerp)
	else:
		downlerp -= delta * sidespeed
		downlerp = max(downlerp, 0)

		position = Vector3(position.x, position.y, downlerp)
	


	move_and_slide()
	var coll = get_last_slide_collision()
	if !coll:
		return
	var otherobj = coll.get_collider()
	if otherobj.is_in_group("enemy"):
		take_damage(coll.get_collider_velocity(0).length())

func take_damage(damage_amount: float):
	PlayerStats.health -= damage_amount
	print(damage_amount)
	if PlayerStats.health <= 0:
		print(name," is dead")

func _process(delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if input_dir.x < 0:
		model.rotation.y = initial_model_rotation.y + PI
	elif input_dir.x > 0:
		model.rotation.y = initial_model_rotation.y 
