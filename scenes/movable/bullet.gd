extends RigidBody3D

var timer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer-=delta
	if timer <= 0:
		for child in get_children():
			child.queue_free()
		queue_free()
