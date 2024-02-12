extends Node3D

@onready var character = get_node("/root/2d_root/character")

func _on_Collectable_area_entered(area):
	if area.is_in_group("character"):
		character.score += 10
		character.play_collect_animation()
		queue_free()
