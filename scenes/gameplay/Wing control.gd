extends Node

# Wing objects
@onready var leftWing = $"../Fairy/Skeleton3D/WingL"
@onready var rightWing = $"../Fairy/Skeleton3D/WingR"


# Parameters for the wing animation
var flapSpeed : float = 2000.0  # Adjust the speed of the flapping
var flapAngle : float = 50.0  # Adjust the maximum angle of rotation during flapping
var flapDirection : int = 1   # 1 for up-down, -1 for down-up (change direction)
var xflap = 0.25
var flapOffset = 40
# Initial angles of the wings
var leftWingInitialAngle : float
var rightWingInitialAngle : float

# Track the current rotation angle
var currentAngle : float = 0.0

func _process(delta):
	currentAngle += flapSpeed * delta
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
