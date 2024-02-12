extends Node3D
@onready var rb = $RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	if Input.is_action_pressed("left"):
		rb.add_constant_force(Vector3(-1,0,0),self.position)
	if Input.is_action_pressed("right"):
		rb.add_constant_force(Vector3(1,0,0),self.position)
	if Input.is_action_just_pressed("jump"):
		rb.add_constant_force(Vector3(0,10,0),self.position)
