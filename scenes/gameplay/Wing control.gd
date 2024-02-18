extends Node

# Wing objects
@onready var leftWing = $"../Fairy/Skeleton3D/WingL"
@onready var rightWing = $"../Fairy/Skeleton3D/WingR"
@onready var character = $"../.."

# Parameters for the wing animation
var flapSpeedBase : float = 2000.0  # Base speed of the flapping
var flapSpeedMultiplier : float = 100.0  # Multiplier for movement speed impact on flapping speed
var flapAngle : float = 50.0  # Adjust the maximum angle of rotation during flapping
var flapDirection : int = 1   # 1 for up-down, -1 for down-up (change direction)
var xflap : float = 0.25
var flapOffset : float = 40

# Initial angles of the wings
var leftWingInitialAngle : float
var rightWingInitialAngle : float

# Track the current rotation angle
var currentAngle : float = 0.0

# Movement speed
var movementSpeed : float = 0.0

func _process(delta):
	movementSpeed = character.velocity.length()
	
	 #Update movement speed and Y-axis movement direction
	var yMovementDirection : float = float(character.velocity.y > 0)
	#if yMovementDirection < 0:
		#yMovementDirection = -10
	

	# Calculate flapping speed based on movement speed and Y-axis movement direction
	#var flapSpeed = flapSpeedBase + movementSpeed * flapSpeedMultiplier * yMovementDirection
	#flapSpeed = max(flapSpeed, 0.1)
	var input_dir = Input.get_vector("left", "right", "up", "down")
	#var direction = (character.transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
	var flapSpeed = flapSpeedBase * input_dir.length() + (float(character.dashtimer/character.dash_time > character.dash_cd_part)*character.dash_speed*200) + movementSpeed * flapSpeedMultiplier * yMovementDirection

	currentAngle += (flapSpeed + character.velocity.length() * flapSpeedMultiplier) * delta
	currentAngle = wrap_angle(currentAngle)

	# Calculate the wing rotation using a sine function for smooth flapping
	var rotation = sin(deg_to_rad(currentAngle)) * flapAngle

	# Apply the rotation to the wings
	leftWing.rotation_degrees.z = leftWingInitialAngle + rotation + flapOffset
	rightWing.rotation_degrees.z = rightWingInitialAngle + rotation + flapOffset

	# Additional rotation for some extra spice
	leftWing.rotation_degrees.x = cos(deg_to_rad(currentAngle)) * flapAngle * xflap
	rightWing.rotation_degrees.x = -cos(deg_to_rad(currentAngle)) * flapAngle * xflap
# Function to wrap angle between 0 and 360 degrees
func wrap_angle(angle):
	return fmod((angle + 360.0), 360.0)
