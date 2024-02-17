extends Node

var current_player
var shining_eggs = 0
var score = 0
var shining_eggs_collected = 0
var levels_unlocked = 1
var health = 100
var max_health = 100
var weapons: Array = []


# Called when the node enters the scene tree for the first time.
func _ready():
	weapons.append(Items.fantasyWand)
	weapons.append(Items.stoneWand)
	weapons.append(Items.bubbleWand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func grab_egg():
	shining_eggs+=1

func reset_health():
	PlayerStats.health = PlayerStats.max_health

func take_damage(damage_amount: float):
	PlayerStats.health -= damage_amount
