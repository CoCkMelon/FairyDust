extends Node

var current_player
var shining_eggs = 0
var score = 0
var shining_eggs_collected = 0
var levels_unlocked = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func grab_egg():
	shining_eggs+=1
