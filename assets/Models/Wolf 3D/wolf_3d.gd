extends Node3D


@onready var animation_player = $AnimationPlayerPlr
@onready var initrot = rotation.y

func _ready():
	animation_player.play("idle")

func _input(event):
	if event.is_action_pressed("jump"):
		animation_player.play("jump")
	elif event.is_action_pressed("left"):
		animation_player.play("fastrun")
		rotation.y = initrot + PI
		print(rotation)
	elif event.is_action_pressed("right"):
		animation_player.play("fastrun")
		rotation.y = initrot
	elif event.is_action_released("jump"):
		animation_player.play("idle")
	elif event.is_action_released("left"):
		animation_player.play("idle")
	elif event.is_action_released("right"):
		animation_player.play("idle")
		
