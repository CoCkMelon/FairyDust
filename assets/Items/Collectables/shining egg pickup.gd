extends Area2D

@onready var pstats = get_node("/root/PlayerStats")

func _ready():
	connect("body_entered", _on_Egg_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Egg_body_entered(body):
	print(body)
	pstats.grab_egg()
	queue_free()

